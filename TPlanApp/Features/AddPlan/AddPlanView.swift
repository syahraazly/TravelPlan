//
//  AddPlanView.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI

struct AddPlanView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var activity: String = ""
    @State private var location: String = ""
    @State private var collaborator: String = ""
    @State private var isAllDay: Bool = false
    @State private var selectedCategory: PlanCategory = .city
    
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
                
                Text("Add Plan")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color(.indigo).opacity(0.9))
            }
            .padding(.horizontal, 28)
            .padding(.top, 60)
            .padding(.bottom, 24)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    
                    // Activity
                    SectionTitle("Activity")
                    
                    VStack(spacing: 0) {
                        TextField("Enter your activity", text: $activity)
                            .padding(.horizontal, 18)
                            .frame(height: 62)
                        
                        Divider()
                            .opacity(0.25)
                        
                        TextField("Enter your location", text: $location)
                            .padding(.horizontal, 18)
                            .frame(height: 62)
                    }
                    .font(.body)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    )
                    
                    // Time
                    SectionTitle("Time")
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("All Day")
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
                    
                    // Collaborator
                    SectionTitle("Collaborator")
                    
                    TextField("Enter your collaborator", text: $collaborator)
                        .font(.body)
                        .padding(.horizontal, 18)
                        .frame(height: 62)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                        )
                    
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
                    Text("Save Plan")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
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
            .font(.title3.weight(.regular))
            .foregroundStyle(Color(.indigo).opacity(0.9))
    }
}

#Preview {
    AddPlanView()
}
