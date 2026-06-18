//
//  EmptyActivityView.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI

struct EmptyActivityView: View {
    
    @ScaledMetric private var height: CGFloat = 280
    @ScaledMetric private var iconSize: CGFloat = 96
    
    var body: some View {
        VStack(spacing: 28) {
            Text("NO ACTIVITY TODAY")
                .font(.title3.weight(.medium))
                .foregroundStyle(.gray.opacity(0.55))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            
            Image(systemName: "tray")
                .font(.system(size: iconSize, weight: .regular))
                .foregroundStyle(.gray.opacity(0.45))
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    .gray.opacity(0.45),
                    style: StrokeStyle(
                        lineWidth: 3,
                        dash: [8, 8]
                    )
                )
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("No plan today")
    }
}

#Preview {
    EmptyActivityView()
}
