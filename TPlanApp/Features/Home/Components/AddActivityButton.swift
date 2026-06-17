//
//  AddActivityButton.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI

struct AddActivityButton: View {
    
    var body: some View {
        Button {
            // TODO: handle add activity
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "plus")
                Text("Add Plan")
            }
            .font(.title3.weight(.bold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.primaryBlue)
            )
        }
        .accessibilityLabel("Add plan")
    }
}

#Preview {
    AddActivityButton()
}
