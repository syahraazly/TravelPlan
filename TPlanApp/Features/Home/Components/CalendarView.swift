//
//  CalendarView.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI

struct CalendarView: View {
    private var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 1 // Sunday
        return calendar
    }
    
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
        let weekday = calendar.component(.weekday, from: firstDay)
        
        return (weekday - calendar.firstWeekday + 7) % 7
    }
    
    private var calendarDays: [Int?] {
        let emptyDays = Array<Int?>(repeating: nil, count: startingSpaces)
        let realDays = (1...daysInMonth).map { Optional($0) }
        return emptyDays + realDays
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
            
            GeometryReader { proxy in
                
                let spacing: CGFloat = 8
                let cellWidth = (proxy.size.width - (spacing * 6)) / 7

                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.fixed(cellWidth), spacing: spacing),
                        count: 7
                    ),
                    spacing: spacing
                ) {
                    
                    ForEach(calendarDays.indices, id: \.self) { index in
                        if let day = calendarDays[index] {
                            DayCellView(
                                day: day,
                                isSelected: day == selectedDay,
                                hasEvent: datesWithEvents.contains(day),
                                onTap: {
                                    selectedDay = day
                                }
                            )
                            .frame(width: cellWidth, height: 48)
                        } else {
                            Color.clear
                                .frame(width: cellWidth, height: 48)
                        }
                    }
                }
            }
            .frame(height: calendarHeight)
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
    
    private var calendarHeight: CGFloat {
        let totalCells = startingSpaces + daysInMonth
        let rows = ceil(Double(totalCells) / 7.0)
        return CGFloat(rows) * 56
    }
}

struct DayCellView: View {
    let day: Int
    let isSelected: Bool
    let hasEvent: Bool
    let onTap: () -> Void
    
    @ScaledMetric(relativeTo: .body) private var scaledCircleSize: CGFloat = 32
    @ScaledMetric(relativeTo: .caption) private var scaledDotSize: CGFloat = 5

    private var circleSize: CGFloat {
        min(scaledCircleSize, 36)
    }

    private var dotSize: CGFloat {
        min(scaledDotSize, 6)
    }

    private var cellHeight: CGFloat {
        48
    }
    
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

