//
//  LocationRow.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 18/06/26.
//

import SwiftUI

struct LocationRow: View {
    let title: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color(.indigo))
                
                Text(title)
                    .font(.callout.weight(.light))
                    .foregroundStyle(Color(.indigo).opacity(0.9))
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 54)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LocationRow(title: "Jl. Pangeran Antasari 3") {
            print("Selected")
        }
        .padding()
        .background(Color(.platinum))
}
