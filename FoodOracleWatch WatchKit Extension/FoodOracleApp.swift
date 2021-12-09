//
//  FoodOracleApp.swift
//  FoodOracleWatch WatchKit Extension
//
//  Created by Aydin Battal on 2021-12-08.
//

import SwiftUI

@main
struct FoodOracleApp: App {
    let fireDbHelper = FireDBHelper()
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(fireDbHelper)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
