//
//  TPlanAppApp.swift
//  TPlanApp
//
//  Created by Syahra Zulya Shania Maghfiroh on 17/06/26.
//

import SwiftUI

@main
struct TPlanAppApp: App {
    
    @State private var hasCompletedOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if hasCompletedOnboarding {
                    ContentView()
                } else {
                    OnBoardingView(
                        hasCompletedOnboarding: $hasCompletedOnboarding
                    )
                }
            }
        }
    }
}
