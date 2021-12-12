//
//  CustomModifiers.swift
//  FoodOracle
//
//  Created by Deep on 2021-12-12.
//

import SwiftUI

//Page to create custom looks for the UI
struct AppTextFieldModifier: ViewModifier{
    
    func body(content: Content) -> some View {
        return content
            .padding(10)
            .autocapitalization(.none)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
            .padding(10)
    }
}

struct AppButtonTextModifier: ViewModifier{
    func body(content: Content) -> some View {
        return content
            .foregroundColor(Color.white)
            .font(.body)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
    }
}

struct AppButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(10)
    }
}
