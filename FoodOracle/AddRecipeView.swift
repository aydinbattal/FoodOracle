//
//  AddRecipeView.swift
//  FoodOracle
//
//  Created by Karan Patel on 2021-12-05.
//

import SwiftUI

struct AddRecipeView: View {
    @State private var description: String = ""
    @State private var ingredients: Array = []
    @State private var steps: String = ""
    @State private var author: String = ""
    @State private var title: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
