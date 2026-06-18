//
//  HomeView.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI
struct HomeView: View {
    
    @ScaledMetric private var addButtonSize: CGFloat = 40
    
    @State private var selectedDay: Int = 2
    
    let datesWithEvents: Set<Int> = [2]
    
    private var selectedDayHasEvent: Bool {
        datesWithEvents.contains(selectedDay)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Header
            HStack {
                Text("T PLAN")
                    .font(.title.weight(.bold))
                    .kerning(1.2)
                    .foregroundStyle(Color(.indigo))
                
                Spacer()
                
                
                NavigationLink {
                    AddPlanView(mode: .add)
                } label: {
                    Image(systemName: "plus")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(.white)
                        .frame(width: addButtonSize, height: addButtonSize)
                        .background(
                            Circle()
                                .fill(Color.primaryBlue)
                        )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
            .padding(.top, 60)
            .padding(.bottom, 20)
            .background(Color(.platinum))
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    CalendarView(
                        selectedDay: $selectedDay,
                        datesWithEvents: datesWithEvents
                    )
                    .padding(.horizontal)
                    
                    HStack {
                        Text("TODAY ACTIVITY")
                            .font(.title3.weight(.bold))
                            .foregroundStyle(Color(.indigo).opacity(0.9))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 36)
                    .padding(.bottom, 20)
                    
                    if selectedDayHasEvent {
                        VStack(spacing: 20) {
                            NavigationLink {
                                DetailPlanView(
                                    title: "Go to Bandung",
                                    category: .city,
                                    dateText: "Wednesday, 10 June 2026",
                                    timeText: "All Day",
                                    collaborators: []
                                )
                            } label: {
                                ActivityCard(
                                    title: "Go to Bandung",
                                    subtitle: "All Day",
                                    locationText: "Jl. Bandung No. 26A",
                                    leadingSystemImage: "building.2.fill",
                                    iconColor: .cityCategory,
                                    iconBackground: .cityCategory.opacity(0.10),
                                    cardBackground: .white
                                )
                            }
                            .buttonStyle(.plain)
                            NavigationLink {
                                DetailPlanView(
                                    title: "Ayam Seruni",
                                    category: .food,
                                    dateText: "Wednesday, 10 June 2026",
                                    timeText: "07.00 - 08.30",
                                    collaborators: []
                                )
                            } label: {
                                ActivityCard(
                                    title: "Ayam Seruni",
                                    subtitle: "07.30 - 09.00",
                                    locationText: "Jl. Padjajaran 1 No. 39 Blok B",
                                    leadingSystemImage: "fork.knife",
                                    iconColor: .orange,
                                    iconBackground: .orange.opacity(0.10),
                                    cardBackground: .white
                                )
                            }
                            .buttonStyle(.plain)
                            NavigationLink {
                                DetailPlanView(
                                    title: "Ranca Upas",
                                    category: .nature,
                                    dateText: "Wednesday, 10 June 2026",
                                    timeText: "09.00 - 15.30",
                                    collaborators: []
                                )
                            } label: {
                                ActivityCard(
                                    title: "Ranca Upas",
                                    subtitle: "09.00 - 15.30",
                                    locationText: "Jl. Ahmad Yani No. 29A",
                                    leadingSystemImage: "tree.fill",
                                    iconColor: .natureCategory,
                                    iconBackground: .natureCategory.opacity(0.12),
                                    cardBackground: .white
                                )
                            }
                            .buttonStyle(.plain)
                            NavigationLink {
                                DetailPlanView(
                                    title: "Bakso Bintang Asia",
                                    category: .food,
                                    dateText: "Wednesday, 10 June 2026",
                                    timeText: "15.30 - 17.00",
                                    collaborators: []
                                )
                            } label: {
                                ActivityCard(
                                    title: "Bakso Bintang Asia",
                                    subtitle: "15.30 - 17.00",
                                    locationText: "Jl. Cihapit No. 9A",
                                    leadingSystemImage: "fork.knife",
                                    iconColor: .foodCategory,
                                    iconBackground: .foodCategory.opacity(0.10),
                                    cardBackground: .white
                                )
                            }
                            .buttonStyle(.plain)
                            NavigationLink {
                                DetailPlanView(
                                    title: "Braga Street",
                                    category: .city,
                                    dateText: "Wednesday, 10 June 2026",
                                    timeText: "17.00 - 18.00",
                                    collaborators: []
                                )
                            } label: {
                                ActivityCard(
                                    title: "Braga Street",
                                    subtitle: "17.00 - 18.00",
                                    locationText: "Jl. Braga Asia No. 6A",
                                    leadingSystemImage: "building.2.fill",
                                    iconColor: .cityCategory,
                                    iconBackground: .cityCategory.opacity(0.10),
                                    cardBackground: .white
                                )
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 32)
                    } else {
                        EmptyActivityView()
                            .padding(.horizontal)
                            .padding(.bottom, 28)
                        
                        AddActivityButton()
                            .padding(.horizontal)
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
