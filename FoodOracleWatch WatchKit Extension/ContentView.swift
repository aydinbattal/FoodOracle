//
//  ContentView.swift
//  FoodOracleWatch WatchKit Extension
//
//  Created by Aydin Battal on 2021-12-08.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fireDbHelper : FireDBHelper
    
    var body: some View {
        Text("Hello, World!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
