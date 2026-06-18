//
//  AddPlanView.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI

struct AddPlanView: View {
    
    @Environment(\.dismiss) private var dismiss
        
    let mode: AddPlanMode
    
    @State private var activity: String
    @State private var isAllDay: Bool
    @State private var selectedCategory: PlanCategory
    
    @State private var location: String
    @State private var showLocationSheet = false
    
    @State private var collaborator: String
    @State private var showCollaborators = false
    @State private var selectedCollaborators: Set<String>
    
    @State private var startDate: Date
    @State private var endDate: Date
    
    init(mode: AddPlanMode = .add) {
        self.mode = mode
        
        switch mode {
        case .add:
            _activity = State(initialValue: "")
            _isAllDay = State(initialValue: false)
            _location = State(initialValue: "")
            _startDate = State(initialValue: Date())
            _endDate = State(initialValue: Date().addingTimeInterval(3600))
            _collaborator = State(initialValue: "")
            _selectedCollaborators = State(initialValue: [])
            _selectedCategory = State(initialValue: .city)
            
        case .edit(let plan):
            _activity = State(initialValue: plan.title)
            _isAllDay = State(initialValue: false)
            _location = State(initialValue: plan.location)
            _startDate = State(initialValue: plan.startDate)
            _endDate = State(initialValue: plan.endDate)
            _collaborator = State(initialValue: plan.collaboratorText)
            _selectedCollaborators = State(
                initialValue: Set(
                    plan.collaboratorText
                        .split(separator: ",")
                        .map { $0.trimmingCharacters(in: .whitespaces) }
                )
            )
            _selectedCategory = State(initialValue: plan.category)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Header
            ZStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2.weight(.semibold))
                            .foregroundStyle(Color(.indigo))
                            .frame(width: 52, height: 52)
                            .background(Circle().fill(Color.white))
                            .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
                    }
                    .accessibilityLabel("Back")
                    
                    Spacer()
                }
                
                Text(mode.title)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color(.indigo).opacity(0.9))
            }
            .padding(.horizontal, 28)
            .padding(.top, 60)
            .padding(.bottom, 24)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 5) {
                    
                    // Activity
                    SectionTitle("Activity")
                    
                    VStack(spacing: 0) {
                        TextField("Enter your activity", text: $activity)
                            .foregroundStyle(
                                activity.isEmpty
                                ? Color(.indigo).opacity(0.7)
                                : Color(.indigo)
                            )
                            .padding(.horizontal, 18)
                            .frame(height: 62)
                        
                        Divider()
                            .opacity(0.25)
                        
                        Button {
                            showLocationSheet = true
                        } label: {
                            HStack {
                                Text(location.isEmpty ? "Enter your location" : location)
                                    .foregroundStyle(
                                        location.isEmpty
                                        ? Color(.indigo).opacity(0.3)
                                        : Color(.indigo)
                                    )
                                
                                Spacer()
                            }
                            .font(.body)
                            .padding(.horizontal, 18)
                            .frame(height: 62)
                        }
                        .buttonStyle(.plain)
                        .sheet(isPresented: $showLocationSheet) {
                            LocationSheet(selectedLocation: $location)
                                .presentationDetents([.large])
                                .presentationDragIndicator(.hidden)
                        }
                    }
                    .font(.body)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    )
                    .padding(.bottom, 13)
                    
                    // Time
                    SectionTitle("Time")
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("All Day")
                                .font(.callout.weight(.light))
                            Spacer()
                            Toggle("", isOn: $isAllDay)
                                .labelsHidden()
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 58)
                        
                        Divider()
                            .opacity(0.25)
                        
                        TimeSectionView()
                    }
                    .font(.body)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    )
                    .padding(.bottom, 13)
                    
                    // Collaborator
                    SectionTitle("Collaborator")
                    
                    Button {
                        showCollaborators = true
                    } label: {
                        HStack {
                            Text(collaborator.isEmpty ? "Enter your collaborator" : collaborator)
                                .foregroundStyle(
                                    collaborator.isEmpty
                                    ? Color(.indigo).opacity(0.3)
                                    : Color(.indigo)
                                )
                            
                            Spacer()
                        }
                        .font(.body)
                        .padding(.horizontal, 18)
                        .frame(height: 62)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                        )
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 13)
                    .sheet(isPresented: $showCollaborators) {
                        CollaboratorsSheet(
                            selectedCollaborators: $selectedCollaborators,
                            collaboratorText: $collaborator
                        )
                        .presentationDetents([.large])
                        .presentationDragIndicator(.hidden)
                    }
                    
                    // Category
                    SectionTitle("Category")
                    
                    HStack(spacing: 20) {
                        ForEach(PlanCategory.allCases) { category in
                            CategoryCard(
                                category: category,
                                isSelected: selectedCategory == category
                            ) {
                                selectedCategory = category
                            }
                        }
                    }
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 120)
            }
            
            VStack(spacing: 18) {
                Button {
                    // TODO: save plan
                } label: {
                    Text(mode.buttonTitle)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.primaryBlue)
                        )
                }
                .accessibilityLabel("Save plan")
                
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(Color(.indigo).opacity(0.9))
                }
                .accessibilityLabel("Cancel")
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 32)
            .background(Color(.platinum))
        }
        .background(Color(.platinum))
        .ignoresSafeArea()
    }
}

struct SectionTitle: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.title3.weight(.medium))
            .foregroundStyle(Color(.indigo))
    }
}

struct Plan: Identifiable {
    let id = UUID()
    var title: String
    var location: String
    var startDate: Date
    var endDate: Date
    var collaboratorText: String
    var category: PlanCategory
}

enum AddPlanMode {
    case add
    case edit(Plan)
    
    var title: String {
        switch self {
        case .add:
            return "Add Plan"
        case .edit:
            return "Edit Plan"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .add:
            return "Save Plan"
        case .edit:
            return "Save Changes"
        }
    }
}

#Preview {
    AddPlanView()
}
