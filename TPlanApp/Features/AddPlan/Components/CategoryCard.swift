//
//  CategoryCard.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI

struct CategoryCard: View {
    let category: PlanCategory
    let isSelected: Bool
    let onTap: () -> Void
    
    @ScaledMetric private var iconSize: CGFloat = 30
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                Image(systemName: category.icon)
                    .font(.system(size: iconSize, weight: .semibold))
                
                Text(category.rawValue)
                    .font(.caption.weight(.regular))
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
            .foregroundStyle(isSelected ? .white : category.color)
            .frame(maxWidth: .infinity)
            .frame(height: 96)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        isSelected
                        ? category.color
                        : category.color.opacity(0.16)
                    )
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(category.rawValue)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

enum PlanCategory: String, CaseIterable, Identifiable {
    case city = "City"
    case food = "Food"
    case nature = "Nature"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .city:
            return "building.2.fill"
        case .food:
            return "fork.knife"
        case .nature:
            return "tree.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .city:
            return .cityCategory
        case .food:
            return .foodCategory
        case .nature:
            return .natureCategory
        }
    }
}

struct CategoryPreview: View {
    
    @State private var selectedCategory: PlanCategory = .city
    
    var body: some View {
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
        .padding()
    }
}

#Preview {
    CategoryPreview()
}
