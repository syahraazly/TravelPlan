//
//  HomeView.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI

struct HomeView: View {
    
    @ScaledMetric private var addButtonSize: CGFloat = 50
    @State private var selectedDay: Int = 2
    
    let plans: [Plan] = [
        
        Plan(
            title: "Go to Bandung",
            location: "Jl. Bandung No. 26A",
            startDate: .custom(year: 2026, month: 6, day: 10),
            endDate: .custom(year: 2026, month: 6, day: 10),
            collaboratorText: "",
            collaborators: [],
            category: .city,
            isAllDay: true
        ),
        
        Plan(
            title: "Ayam Seruni",
            location: "Jl. Padjajaran 1 No. 39 Blok B",
            startDate: .custom(year: 2026, month: 6, day: 10, hour: 7, minute: 30),
            endDate: .custom(year: 2026, month: 6, day: 10, hour: 9, minute: 0),
            collaboratorText: "Diana, Ichi, Dina",
            collaborators: [
                "Diana",
                "Ichi",
                "Dina"
            ],
            category: .food,
            isAllDay: false
        ),
        
        Plan(
            title: "Ranca Upas",
            location: "Jl. Ahmad Yani No. 29A",
            startDate: .custom(year: 2026, month: 6, day: 10, hour: 9, minute: 0),
            endDate: .custom(year: 2026, month: 6, day: 10, hour: 15, minute: 30),
            collaboratorText: "",
            collaborators: [],
            category: .nature,
            isAllDay: false
        ),
        
        Plan(
            title: "Bakso Bintang Asia",
            location: "Jl. Cihapit No. 9A",
            startDate: .custom(year: 2026, month: 6, day: 10, hour: 15, minute: 30),
            endDate: .custom(year: 2026, month: 6, day: 10, hour: 17, minute: 0),
            collaboratorText: "",
            collaborators: [],
            category: .food,
            isAllDay: false
        ),
        
        Plan(
            title: "Braga Street",
            location: "Jl. Braga Asia No. 6A",
            startDate: .custom(year: 2026, month: 6, day: 10, hour: 17, minute: 0),
            endDate: .custom(year: 2026, month: 6, day: 10, hour: 18, minute: 0),
            collaboratorText: "",
            collaborators: [],
            category: .city,
            isAllDay: false
        )
    ]
    
    private var datesWithEvents: Set<Int> {
        [2]
    }
    
    private var selectedPlans: [Plan] {
        datesWithEvents.contains(selectedDay) ? plans : []
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Header
            HStack {
                Text("NGEPLAN")
                    .font(.title.weight(.bold))
                    .kerning(1.2)
                    .foregroundStyle(Color(.indigo))
                
                Spacer()
                
                NavigationLink {
                    AddPlanView(mode: .add)
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.bold))
                        .foregroundStyle(.white)
                        .frame(width: addButtonSize, height: addButtonSize)
                        .background(Circle().fill(Color.primaryBlue))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
            .padding(.bottom, 20)
            .background(Color(.platinum))
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    CalendarView(
                        selectedDay: $selectedDay,
                        datesWithEvents: datesWithEvents
                    )
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Text("TODAY ACTIVITY")
                            .font(.title3.weight(.bold))
                            .foregroundStyle(Color(.indigo).opacity(0.9))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 36)
                    .padding(.bottom, 20)
                    
                    if selectedPlans.isEmpty {
                        EmptyActivityView()
                            .padding(.horizontal)
                            .padding(.bottom, 28)
                        
                        AddActivityButton()
                            .padding(.horizontal)
                            .padding(.bottom, 32)
                    } else {
                        VStack(spacing: 20) {
                            ForEach(selectedPlans) { plan in
                                NavigationLink {
                                    DetailPlanView(plan: plan)
                                } label: {
                                    ActivityCard(
                                        title: plan.title,
                                        subtitle: plan.isAllDay ? "All Day" : "07.00 - 08.30",
                                        locationText: plan.location,
                                        leadingSystemImage: plan.category.icon,
                                        iconColor: plan.category.color,
                                        iconBackground: plan.category.color.opacity(0.10),
                                        cardBackground: .white
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 32)
                    }
                }
            }
        }
        .background(Color(.platinum))
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}

