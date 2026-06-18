//
//  NoCollaboratorView.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 18/06/26.
//

import SwiftUI

struct NoCollaboratorView: View {
    var body: some View {
        HStack(spacing: 13) {
            Image(systemName: "person.crop.circle.badge.xmark")
                .font(.title2)
                .foregroundStyle(Color(.indigo).opacity(0.45))
            
            Text("No collaborators yet")
                .font(.body)
                .foregroundStyle(Color(.indigo).opacity(0.55))
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.8))
        )
    }
}

#Preview {
    NoCollaboratorView()
}
