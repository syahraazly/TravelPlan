//
//  CalendarView.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI

struct CalendarView: View {
    private let calendar = Calendar.current
    
    @State private var displayedMonth: Date = Date()
    @Binding var selectedDay: Int
    
    let datesWithEvents: Set<Int>
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    private let weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

    private var displayedWeekdays: [String] {
        dynamicTypeSize.isAccessibilitySize
        ? weekdays.map { String($0.prefix(1)) }
        : weekdays
    }
    
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 8),
        count: 7
    )

    private var monthTitle: String {
        if dynamicTypeSize.isAccessibilitySize {
            return displayedMonth.formatted(.dateTime.month(.abbreviated).year())
        } else {
            return displayedMonth.formatted(.dateTime.month(.wide).year())
        }
    }
    
    private var daysInMonth: Int {
        calendar.range(of: .day, in: .month, for: displayedMonth)?.count ?? 30
    }
    
    private var startingSpaces: Int {
        let components = calendar.dateComponents([.year, .month], from: displayedMonth)
        let firstDay = calendar.date(from: components) ?? displayedMonth
        return calendar.component(.weekday, from: firstDay) - 1
    }
    
    var body: some View {
        VStack(spacing: 24) {
            
            HStack {
                HStack(spacing: 8) {
                    Text(monthTitle)
                        .font(.title3.weight(.bold))
                        .foregroundColor(Color(.indigo))
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    
                    Image(systemName: "chevron.right")
                        .font(.body.weight(.semibold))
                        .foregroundColor(.primaryBlue)
                }
                
                Spacer()
                
                HStack(spacing: 24) {
                    Button {
                        changeMonth(by: -1)
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.primaryBlue)
                    }
                    .accessibilityLabel("Previous month")
                    
                    Button {
                        changeMonth(by: 1)
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.primaryBlue)
                    }
                    .accessibilityLabel("Next month")
                }
            }
            
            HStack {
                ForEach(displayedWeekdays, id: \.self) { day in
                    Text(day)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.gray.opacity(0.8))
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(0..<startingSpaces, id: \.self) { _ in
                    Color.clear
                        .frame(height: 48)
                }
                
                ForEach(1...daysInMonth, id: \.self) { day in
                    let date = makeDate(day: day)
                    
                    DayCellView(
                        day: day,
                        isSelected: day == selectedDay,
                        hasEvent: datesWithEvents.contains(day),
                        onTap: {
                            selectedDay = day
                        }
                    )
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 8)
    }
    
    private func makeDate(day: Int) -> Date {
        var components = calendar.dateComponents([.year, .month], from: displayedMonth)
        components.day = day
        return calendar.date(from: components) ?? displayedMonth
    }
    
    private func changeMonth(by value: Int) {
        displayedMonth = calendar.date(
            byAdding: .month,
            value: value,
            to: displayedMonth
        ) ?? displayedMonth
    }
}

struct DayCellView: View {
    let day: Int
    let isSelected: Bool
    let hasEvent: Bool
    let onTap: () -> Void
    
    @ScaledMetric(relativeTo: .body) private var circleSize: CGFloat = 32
    @ScaledMetric(relativeTo: .caption) private var dotSize: CGFloat = 5
    @ScaledMetric(relativeTo: .body) private var cellHeight: CGFloat = 48
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Text("\(day)")
                    .font(.body)
                    .foregroundColor(
                        isSelected
                        ? Color.primaryBlue
                        : Color(red: 0.16, green: 0.18, blue: 0.26)
                    )
                    .frame(width: circleSize, height: circleSize)
                    .background(
                        Circle()
                            .fill(isSelected ? Color.primaryBlue.opacity(0.15) : Color.clear)
                    )
                
                Circle()
                    .fill(hasEvent ? Color.primaryBlue : Color.clear)
                    .frame(width: dotSize, height: dotSize)
            }
            .frame(maxWidth: .infinity)
            .frame(height: cellHeight)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Date \(day)")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityHint(hasEvent ? "Has event" : "")
    }
}

#Preview {
    CalendarView(
        selectedDay: .constant(2),
        datesWithEvents: [2]
    )
    .background(Color(.systemGray6))
}

