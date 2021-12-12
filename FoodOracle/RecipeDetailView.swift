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
            TextField("Enter title", text: self.$title)
                .autocapitalization(.words)
                .font(.title)
                .padding(25)
            
            Form{
                Section(header: Text("Description")){
                TextField("Enter Description", text: self.$description)
                    .autocapitalization(.words)
                }
                
                Section(header: Text("Ingredients")){
                    ForEach(ingredients, id: \.self){ Ingredient in
                        HStack{
                            Text(String(Ingredient.amount))
                            Text(Ingredient.ingredientName)
                        }
                    }//foreach
                    .onDelete(perform: deleteIngredients)
                }//section for ingredients
                
                Section(header: Text("Steps")){
                    ForEach(stepsList, id: \.self){ step in
                        Text(step)                        
                    }
                    .onDelete(perform: deleteSteps)
                }//section for steps
                
                Toggle(isOn: self.$isFavourite, label: {
                    Text("Favourite")
                })
                
            }//Form
            
            Button(action:{
                self.updateRecipe()
            }){
                Text("Update Recipe Details")
                    .fontWeight(.bold)
                    .modifier(AppButtonTextModifier())
            }
            .modifier(AppButtonModifier())
            
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
        self.fireDBHelper.recipeList[selectedRecipeIndex].title = self.title
        self.fireDBHelper.recipeList[selectedRecipeIndex].description = self.description
        self.fireDBHelper.recipeList[selectedRecipeIndex].ingredients = self.ingredients
        self.fireDBHelper.recipeList[selectedRecipeIndex].steps = self.stepsList
        self.fireDBHelper.recipeList[selectedRecipeIndex].isFavourite = self.isFavourite
    }
    
    func deleteIngredients(at offsets: IndexSet) {
            ingredients.remove(atOffsets: offsets)
    }
    func deleteSteps(at offsets: IndexSet) {
            stepsList.remove(atOffsets: offsets)
    }
}


