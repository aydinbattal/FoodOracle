//
//  FoodOracleApp.swift
//  FoodOracle
//
//  Created by Aydin Battal on 2021-11-22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct FoodOracleApp: App {
    let fireDBHelper: FireDBHelper
    
    init(){
        FirebaseApp.configure()
        fireDBHelper = FireDBHelper(database: Firestore.firestore())
    }
    
    var body: some Scene {
        WindowGroup {
         ContentView().environmentObject(fireDBHelper)
//            AddRecipeView().environmentObject(fireDBHelper)
        }
    }
}
