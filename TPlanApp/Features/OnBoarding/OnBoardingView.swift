//
//  OnBoardingView.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 18/06/26.
//

import SwiftUI

struct OnBoardingView: View {
    
    @Binding var hasCompletedOnboarding: Bool
    
    var body: some View {
        ZStack {
            Color.platinum
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // MARK: Logo
                VStack(spacing: 18) {
                    Image("planora-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)

                    Text("Planora")
                        .font(.system(size: 44, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.indigo)

                    VStack(spacing: 4) {
                        Text("Plan beautifully.")
                            .font(.title3)
                            .foregroundStyle(.indigo)

                        HStack(spacing: 4) {
                            Text("Travel")
                                .foregroundStyle(.indigo)

                            HStack(spacing: 0) {
                                Text("co")
                                    .foregroundStyle(.primaryBlue)
                                
                                Text("lor")
                                    .foregroundStyle(.natureCategory)
                                
                                Text("ful")
                                    .foregroundStyle(.foodCategory)
                                
                                Text("ly")
                                    .foregroundStyle(.cityCategory)
                            }
                            
                        }
                        .font(.title3)
                    }
                }

                Spacer()

                // MARK: Illustration
                ZStack(alignment: .bottom) {
                    Circle()
                        .fill(Color.cityCategory.opacity(0.2))
                        .frame(width: 300, height: 300)
                        .offset(x: 80, y: 50)

                    Circle()
                        .fill(Color.natureCategory)
                        .frame(width: 300, height: 300)
                        .offset(x: -70, y: 230)

                    Circle()
                        .fill(Color.foodCategory)
                        .frame(width: 300, height: 300)
                        .offset(x: 180, y: 150)

                    Image(systemName: "airplane")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(Color.primaryBlue)
                        .rotationEffect(.degrees(-25))
                        .offset(x: -70, y: -250)

                    Image(systemName: "calendar")
                        .font(.system(size: 60, weight: .semibold))
                        .foregroundStyle(Color.natureCategory)
                        .padding(14)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .offset(x: 80, y: -125)

                    Image(systemName: "mappin")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundStyle(Color.cityCategory)
                        .offset(x: -120, y: -60)
                }
                .frame(height: 260)

                Button {
                    hasCompletedOnboarding = true
                } label: {
                    Text("Get Started")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.primaryBlue)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 14)
                        )
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 36)
            }
        }
    }
}

#Preview {
    OnBoardingView(hasCompletedOnboarding: .constant(false))
}
