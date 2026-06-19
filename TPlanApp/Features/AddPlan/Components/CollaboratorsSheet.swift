//
//  CollaboratorsSheet.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 18/06/26.
//

import SwiftUI

struct CollaboratorsSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedCollaborators: Set<String>
    @Binding var collaboratorText: String
    
    @State private var searchText = ""
    
    private let collaborators = ["Diana", "Ichi", "Dina", "Anisya", "Ayu"]
    
    private var filteredCollaborators: [String] {
        if searchText.isEmpty {
            collaborators
        } else {
            collaborators.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                Text("Collaborators")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color(.indigo))
                
                HStack {
                    Spacer()
                    
                    Button {
                        updateCollaboratorText()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3.weight(.bold))
                            .foregroundStyle(Color(.indigo))
                            .frame(width: 50, height: 50)
                            .background(Circle().fill(Color.white))
                            .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
                    }
                    .accessibilityLabel("Close")
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 28)
            .padding(.bottom, 24)
            
            HStack(spacing: 14) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundStyle(Color(.indigo))
                
                TextField("Search", text: $searchText)
                    .font(.callout.weight(.light))
                    .foregroundStyle(Color(.indigo))
            }
            .padding(.horizontal, 16)
//            .frame(height: 45)
            .padding(.vertical)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.platinum))
            )
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
            
            VStack(spacing: 14) {
                ForEach(filteredCollaborators, id: \.self) { name in
                    CollaboratorRow(
                        name: name,
                        isAdded: selectedCollaborators.contains(name)
                    ) {
                        toggleCollaborator(name)
                    }
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .background(Color.white)
    }
    
    private func toggleCollaborator(_ name: String) {
        if selectedCollaborators.contains(name) {
            selectedCollaborators.remove(name)
        } else {
            selectedCollaborators.insert(name)
        }
        
        updateCollaboratorText()
    }
    
    private func updateCollaboratorText() {
        collaboratorText = selectedCollaborators.sorted().joined(separator: ", ")
    }
}

#Preview {
    CollaboratorsSheet(
        selectedCollaborators: .constant(["Ichi", "Dina"]),
        collaboratorText: .constant("Ichi, Dina")
    )
}
