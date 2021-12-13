//
//  SplashScreenView.swift
//  FoodOracle
//
//  Created by Karan Patel on 2021-12-08.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive: Bool = false
    let main = ContentView()
    @State private var selection: Int? = nil

    var body: some View {
        VStack(alignment: .center) {
            if self.isActive {
                
                ContentView()
            } else {
                Text("Food Oracle")
                    .font(.largeTitle)
                Image("foodoracle")
            }
        }        
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}
