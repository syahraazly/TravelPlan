//
//  DetailPlanView.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 18/06/26.
//

import SwiftUI

struct DetailPlanView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let plan: Plan
    
    @State private var collaborator: String = ""
    @State private var showCollaborators = false
    @State private var selectedCollaborators: Set<String> = ["Ichi", "Dina"]
    
    private var dateText: String {
        plan.startDate.formatted(.dateTime.weekday(.wide).day().month(.wide).year())
    }
    
    private var timeText: String {
        if plan.isAllDay {
            return "All Day"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH.mm"
        
        return "\(formatter.string(from: plan.startDate)) - \(formatter.string(from: plan.endDate))"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(Color(.indigo))
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(Color.white))
                }
                
                Spacer()
                
                NavigationLink {
                    AddPlanView(mode: .edit(plan))
                } label: {
                    Image(systemName: "note.text.badge.plus")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(Color.primaryBlue))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 32)
            .padding(.top, 60)
            .padding(.bottom, 32)
            
            HStack(spacing: 10) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(plan.category.color.opacity(0.12))
                    
                    Image(systemName: plan.category.icon)
                        .font(.title2.weight(.regular))
                        .foregroundStyle(plan.category.color)
                }
                .frame(width: 40, height: 40)
                
                Text(plan.title)
                    .font(.title.weight(.medium))
                    .foregroundStyle(Color(.indigo).opacity(0.9))
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 14)
            
            VStack(alignment: .leading, spacing: 10) {
                Label(dateText, systemImage: "calendar")
                Label(timeText, systemImage: "clock.fill")
            }
            .font(.body.weight(.regular))
            .foregroundStyle(Color(.indigo))
            .padding(.horizontal, 32)
            .padding(.bottom, 14)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.indigo).opacity(0.8))
                .frame(height: 260)
                .overlay {
                    Text("Map Preview")
                        .foregroundStyle(.white.opacity(0.8))
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 14)
            
            Text("Collaborators")
                .font(.title3.weight(.medium))
                .foregroundStyle(Color(.indigo))
                .padding(.horizontal, 32)
                .padding(.bottom, 14)
            
            if plan.collaborators.isEmpty {
                NoCollaboratorView()
                    .padding(.horizontal, 32)
                    .padding(.bottom, 24)
            } else {
                CollaboratorAvatarList(collaborators: plan.collaborators)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 24)
            }
            
            Button {
                showCollaborators = true
            } label: {
                Label("Add Collaborators", systemImage: "plus")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.primaryBlue)
                    )
            }
            .padding(.horizontal, 32)
            .sheet(isPresented: $showCollaborators) {
                CollaboratorsSheet(
                    selectedCollaborators: $selectedCollaborators,
                    collaboratorText: $collaborator
                )
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
            }
            
            Spacer()
        }
        .background(Color(.platinum))
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DetailPlanView(
        plan: Plan(
            title: "Ayam Seruni",
            location: "Jl. Padjajaran 1 No. 39 Blok B",
            startDate: .custom(year: 2026, month: 6, day: 10, hour: 7, minute: 0),
            endDate: .custom(year: 2026, month: 6, day: 10, hour: 8, minute: 30),
            collaboratorText: "Asep, Budi, Cendri",
            collaborators: ["Asep", "Budi", "Cendri"],
            category: .food,
            isAllDay: false
        )
    )
}
