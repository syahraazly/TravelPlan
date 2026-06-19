//
//  CollaboratorAvatarList.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 18/06/26.
//

import SwiftUI

struct CollaboratorAvatarList: View {
    let collaborators: [String]
    
    var visibleCollaborators: [String] {
        Array(collaborators.prefix(6))
    }
    
    var remainingCount: Int {
        max(collaborators.count - 6, 0)
    }
    
    var body: some View {
        HStack(spacing: 13) {
            ForEach(visibleCollaborators, id: \.self) { name in
                Image(systemName: "person.fill")
                    .font(.title3)
                    .foregroundStyle(.yellow)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color.pink.opacity(0.9))
                    )
            }
            
            if remainingCount > 0 {
                Circle()
                    .fill(Color(.indigo))
                    .frame(width: 40, height: 40)
                    .overlay {
                        Text("+\(remainingCount)")
                            .font(.callout.weight(.medium))
                            .foregroundStyle(.white)
                    }
            }
        }
    }
}

#Preview {
    CollaboratorAvatarList(
        collaborators: [
            "Diana",
            "Ichi",
            "Dina",
            "Anisya",
            "Ayu",
            "Budi",
            "Salsa",
            "Raka"
        ]
    )
    .padding()
}
