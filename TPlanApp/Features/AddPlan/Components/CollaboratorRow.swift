//
//  CollaboratorRow.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 18/06/26.
//

import SwiftUI

struct CollaboratorRow: View {
    let name: String
    let isAdded: Bool
    let onTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.pink.opacity(0.9))
                    .frame(width: 32, height: 32)
                
                Image(systemName: "person.fill")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.yellow)
            }
            
            Text(name)
                .font(.callout.weight(.regular))
                .foregroundStyle(Color(.indigo).opacity(0.9))
            
            Spacer()
            
            Button(action: onTap) {
                Text(isAdded ? "Added" : "Add")
                    .font(.footnote.weight(.bold))
                    .foregroundStyle(isAdded ? .white : Color(.indigo))
                    .padding(.horizontal, 18)
                    .padding(.vertical, 7)
                    .background(
                        Capsule()
                            .fill(isAdded ? Color(.indigo) : Color.clear)
                    )
                    .overlay(
                        Capsule()
                            .stroke(Color(.indigo), lineWidth: isAdded ? 0 : 1)
                    )
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 56)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.platinum))
        )
    }
}

#Preview {
    VStack(spacing: 14) {
        CollaboratorRow(
            name: "Diana",
            isAdded: false
        ) {
            print("Add Diana")
        }
        
        CollaboratorRow(
            name: "Ichi",
            isAdded: true
        ) {
            print("Remove Ichi")
        }
    }
    .padding()
    .background(Color.white)
}
