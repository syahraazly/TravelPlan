//
//  DetailPlanView.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 18/06/26.
//

import SwiftUI

struct DetailPlanView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let title: String
    let category: PlanCategory
    let dateText: String
    let timeText: String
    let collaborators: [String]
    
    @State private var collaborator: String = ""
    @State private var showCollaborators = false
    @State private var selectedCollaborators: Set<String> = ["Ichi", "Dina"]
    
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
                    AddPlanView(
                        mode: .edit(
                            Plan(
                                title: "Ayam Seruni",
                                location: "Jl. Padjajaran 1 No. 39 Blok B",
                                startDate: Date(),
                                endDate: Date().addingTimeInterval(5400),
                                collaboratorText: "Diana, Ichi, Dina",
                                category: .food
                            )
                        )
                    )
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
                        .fill(category.color.opacity(0.12))
                    
                    Image(systemName: category.icon)
                        .font(.title2.weight(.regular))
                        .foregroundStyle(category.color)
                }
                .frame(width: 40, height: 40)
                
                Text(title)
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
            
            if collaborators.isEmpty {
                NoCollaboratorView()
                    .padding(.horizontal, 32)
                    .padding(.bottom, 24)
            } else {
                CollaboratorAvatarList(collaborators: collaborators)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 24)
            }
            
            Button {
                // TODO: add collaborators
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
        title: "Ayam Seruni",
        category: .food,
        dateText: "Wednesday, 10 June 2026",
        timeText: "07.00 - 08.30",
        collaborators: ["Asep", "Budi", "Cendri"]
    )
}
