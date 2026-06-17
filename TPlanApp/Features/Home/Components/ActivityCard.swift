//
//  ActivityCard.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI

struct ActivityCard: View {
    // Reusable configurable properties
    let title: String
    let subtitle: String
    let locationText: String?
    let leadingSystemImage: String

    // Icon color and its soft background
    let iconColor: Color
    let iconBackground: Color

    // Card background (soft surface)
    let cardBackground: Color

    init(
        title: String = "Go to Bandung",
        subtitle: String = "All Day",
        locationText: String? = "Jl. Bandung No. 26A",
        leadingSystemImage: String = "building.2.fill",
        iconColor: Color = Color.pink,
        iconBackground: Color = Color.pink.opacity(0.15),
        cardBackground: Color = Color.white
    ) {
        self.title = title
        self.subtitle = subtitle
        self.locationText = locationText
        self.leadingSystemImage = leadingSystemImage
        self.iconColor = iconColor
        self.iconBackground = iconBackground
        self.cardBackground = cardBackground
    }

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // Leading icon with rounded square background
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(iconBackground)
                    .frame(width: 60, height: 60)
                    .accessibilityHidden(true)

                Image(systemName: leadingSystemImage)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(iconColor)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3.weight(.medium))
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)
                    .foregroundStyle(.primary)

                Text(subtitle)
                    .font(.subheadline.weight(.light))
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)

                if let locationText {
                    HStack(spacing: 8) {
                        Image(systemName: "map.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.secondary)
                        Text(locationText)
                            .font(.subheadline.weight(.light))
                            .lineLimit(2)
                            .minimumScaleFactor(0.85)
                    }
                    .padding(.top, 2)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel(AccessibilityLabelBuilder.build(title: title, subtitle: subtitle, location: locationText))
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(cardBackground)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 6)
        .shadow(color: Color.black.opacity(0.02), radius: 2, x: 0, y: 1)
        .dynamicTypeSize(...DynamicTypeSize.accessibility3)
    }
}

private enum AccessibilityLabelBuilder {
    static func build(title: String, subtitle: String, location: String?) -> String {
        if let location, !location.isEmpty {
            return "\(title), \(subtitle). Location: \(location)."
        } else {
            return "\(title), \(subtitle)."
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        // Example matching the screenshot
        ActivityCard(
            title: "Go to Bandung",
            subtitle: "All Day",
            locationText: "Jl. Bandung No. 26A",
            leadingSystemImage: "building.2.fill",
            iconColor: Color.pink,
            iconBackground: Color.pink.opacity(0.10),
            cardBackground: Color.white
        )
        .padding(.horizontal)
        .background(Color(.systemGray6))

        // Another variant using your custom palette if available
        ActivityCard(
            title: "Meet with Team",
            subtitle: "10:00 AM — 11:30 AM",
            locationText: "Room 3B",
            leadingSystemImage: "person.3.fill",
            iconColor: Color.indigo,
            iconBackground: Color.indigo.opacity(0.10),
            cardBackground: Color.white
        )
        .padding(.horizontal)
        .background(Color(.systemGray6))
    }
}
