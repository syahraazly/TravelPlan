//
//  LocationSheet.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 18/06/26.
//

import SwiftUI

struct LocationSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedLocation: String
    @State private var searchText = ""
    
    private let recentLocations = [
        "Jl. Pangeran Antasari 3",
        "Dukuh Atas BNI",
        "Jl. Cassia V",
        "Jl. Bengawan Solo",
        "Aeon Mall Jakarta Garden City"
    ]
    
    private var filteredLocations: [String] {
        if searchText.isEmpty {
            return recentLocations
        } else {
            return recentLocations.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                
                ZStack {
                    Text("Location")
                        .font(.title2.weight(.medium))
                        .foregroundStyle(Color(.indigo).opacity(0.9))
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title2.weight(.medium))
                                .foregroundStyle(Color(.indigo))
                            //                            .frame(width: 52, height: 52)
                                .padding()
                                .background(Circle().fill(Color.white))
                                .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 28)
                .padding(.bottom, 24)
                
                HStack(spacing: 14) {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                        .foregroundStyle(Color(.indigo))
                    
                    TextField("Search", text: $searchText)
                        .font(.body)
                }
                .padding(.horizontal, 16)
                .padding(.vertical)
//                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.platinum))
                )
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
                
                Button {
                    selectedLocation = "Current Location"
                    dismiss()
                } label: {
                    HStack(spacing: 14) {
                        Image(systemName: "location.fill")
                            .font(.title3)
                        
                        Text("Current Location")
                            .font(.body)
                        
                        Spacer()
                    }
                    .foregroundStyle(Color(.indigo))
                    .padding(.horizontal, 16)
                    .padding(.vertical)
//                    .frame(height: 52)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.platinum))
                    )
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 24)
                .padding(.bottom, 14)
                
                HStack {
                    Text("Recent")
                        .font(.caption)
                        .foregroundStyle(Color(.indigo).opacity(0.65))
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 8)
                
                VStack(spacing: 0) {
                    ForEach(filteredLocations, id: \.self) { location in
                        LocationRow(title: location) {
                            selectedLocation = location
                            dismiss()
                        }
                        
                        if location != filteredLocations.last {
                            Divider()
                                .padding(.leading, 52)
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.platinum))
                )
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
        .background(Color.white)
    }
}

#Preview {
    LocationSheet(selectedLocation: .constant(""))
}
