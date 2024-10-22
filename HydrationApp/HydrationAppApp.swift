//
//  HydrationAppApp.swift
//  HydrationApp
//
//  Created by Maryam on 22/10/2024.
//

import SwiftUI

@main
struct HydrationAppApp: App {
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    var body: some Scene {
        WindowGroup {
            
            if hasLaunchedBefore {
                todayProgress(weight: "70") // Show ProgressView if launched before
                    .onAppear {
                                            print("App launched before.")
                                        }
            } else {
                ContentView() // Show ContentView if first launch
                    .onAppear {
                        print("First launch, setting hasLaunchedBefore to true.")
                        // Set hasLaunchedBefore to true when the app is launched for the first time
                        hasLaunchedBefore = true
                    }
                
            }
        }
    }
}
