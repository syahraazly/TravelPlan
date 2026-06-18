//
//  TimeRowSelector.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI

struct TimeRowSelector: View {
    let title: String
    @Binding var selectedDate: Date
    
    @State private var pickerMode: PickerMode?
    
    enum PickerMode {
        case date
        case time
    }
    
    private var dateText: String {
        selectedDate.formatted(.dateTime.day().month(.abbreviated).year())
    }
    
    private var timeText: String {
        selectedDate.formatted(.dateTime.hour().minute())
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .foregroundStyle(Color(.indigo))
                    .font(.callout.weight(.light))
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut) {
                        pickerMode = pickerMode == .date ? nil : .date
                    }
                } label: {
                    Text(dateText)
                        .font(.caption.weight(.light))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(Color(.platinum)))
                }
                .buttonStyle(.plain)
                
                Button {
                    withAnimation(.easeInOut) {
                        pickerMode = pickerMode == .time ? nil : .time
                    }
                } label: {
                    Text(timeText)
                        .font(.caption.weight(.light))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(Color(.platinum)))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 12)
            .frame(height: 58)
            
            if pickerMode == .date {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .labelsHidden()
                .padding()
            }
            
            if pickerMode == .time {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .frame(height: 180)
                .clipped()
                .padding(.horizontal, 12)
            }
        }
    }
}

struct TimeSectionView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        VStack(spacing: 0) {
            TimeRowSelector(
                title: "Start",
                selectedDate: $startDate
            )
            
            Divider().opacity(0.25)
            
            TimeRowSelector(
                title: "End",
                selectedDate: $endDate
            )
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
    }
}

#Preview {
    TimeSectionView()
        .padding()
        .background(Color(.platinum))
}
