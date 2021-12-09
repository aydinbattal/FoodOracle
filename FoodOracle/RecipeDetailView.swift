//
//  RecipeDetailView.swift
//  FoodOracle
//
//  Created by Deep on 2021-12-09.
//

import SwiftUI

struct RecipeDetailView: View {
    let selectedRecipeIndex : Int
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    @State private var ingredients:  [Ingredient] = []
    @State private var stepsList: [String] = []
    
    @State private var isFavourite: Bool = false
    
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    var body: some View {
        VStack{
            Text("Recipe")
                .font(.title)
                .padding(50)
            
            Form{
                TextField("Enter title", text: self.$title)
                    .autocapitalization(.words)
                
                TextField("Enter Description", text: self.$description)
                    .autocapitalization(.words)
                
                Section(header: Text("Ingredients")){
                    ForEach(ingredients, id: \.self){ Ingredient in
                        HStack{
                            Text(String(Ingredient.amount))
                            Text(Ingredient.ingredientName)
                        }
                    }
                }//section for ingredients
                
                Section(header: Text("Steps")){
                    ForEach(stepsList, id: \.self){ step in
                        Text(step)                        
                    }
                }//section for ingredients
                
                
                Toggle(isOn: self.$isFavourite, label: {
                    Text("Favourite")
                })
                
            }//Form
            
            Button(action:{
                self.updateRecipe()
            }){
                Text("Update Recipe Details")
            }
            
            Spacer()
        }//VStack
        .frame(maxWidth: .infinity)
        .onAppear(){
            self.title = self.fireDBHelper.recipeList[selectedRecipeIndex].title
            self.description = self.fireDBHelper.recipeList[selectedRecipeIndex].description
            self.ingredients = self.fireDBHelper.recipeList[selectedRecipeIndex].ingredients
            self.stepsList = self.fireDBHelper.recipeList[selectedRecipeIndex].steps
            self.isFavourite = self.fireDBHelper.recipeList[selectedRecipeIndex].isFavourite
        }
    }//body
    
    private func updateRecipe(){
        //update the recipe
        
    }
}


