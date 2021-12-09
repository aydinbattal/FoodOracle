//
//  SplashScreenView.swift
//  FoodOracle
//
//  Created by Karan Patel on 2021-12-08.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    let main = ContentView()
    let color = Color.init("black_1")

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Image("foodoracle")
                NavigationLink(destination: main,
                               isActive: $isActive,
                               label: { EmptyView() })
            }
            .background(color)
            .onAppear(perform: {
                self.gotoMainScreen(time: 2.5)
            })
        }
    }

    func gotoMainScreen(time: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
            self.isActive = true
        }
    }
}
