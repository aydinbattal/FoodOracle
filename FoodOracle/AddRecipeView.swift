//
//  AddRecipeView.swift
//  FoodOracle
//
//  Created by Karan Patel on 2021-12-05.
//

import SwiftUI

struct AddRecipeView: View {
    @State private var description: String = ""
    @State private var ingredientAmount: Int = 0
    @State private var ingredientName: String = ""
   // @State private var ingredientInput = "First, Second"
   // @State private var ingredientInputArr = ingredientInput.components(separatedBy: ",")
    //make
    @State private var ingredientInput: String = ""
    @State private var steps: String = ""
    @State private var title: String = ""
    @State private var isFavourite: Bool = false
    @State private var ingredients:  [Ingredient] = []
    @State private var stepsList: [String] = []
  
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    TextField("Enter title", text: self.$title)
                        .autocapitalization(.words)
                    
                    TextField("Enter Description", text: self.$description)
                        .autocapitalization(.words)
                   
                    HStack{
                        TextField("Enter ingridient name", text: self.$ingredientName)
                            .autocapitalization(.words)
                        TextField("Enter ingridient amount", value: self.$ingredientAmount, formatter: NumberFormatter())
                            .autocapitalization(.words)
                       
                        
                    }
                    Button(action: {self.addIngredient()}){Text("Add Ingredient")}
                  
                    
                    TextField("Enter Steps", text: self.$steps)
                        .autocapitalization(.words)
                    Button(action: {self.addSteps()}){Text("Add Steps")}
                    
                    Toggle(isOn: self.$isFavourite, label: {
                        Text("Favourite")
                    })
                    
                }//Form
                
                Button(action: {
                    self.addNewRecipe()
                  
                }){
                    Text("Add Recipe")
                    
                }
                
                Spacer()
            }//VStack
        }//navigation view
    }//body
    private func addNewRecipe(){
      //  var listOfIngredients = [Ingredient]()
     //   listOfIngredients.append(Ingredient(amount: self.ingredientAmount, ingredientName: self.ingredientName))
       // var listOfSteps = [String]()
      //  listOfSteps.append(String(steps))
        print("Adding recipe to database")
        if (!self.title.isEmpty && !self.description.isEmpty){
            //add to database
            self.fireDBHelper.addRecipe(newRecipe: Recipe(title: self.title, description: self.description, ingredients: ingredients, steps: stepsList, isFavourite: self.isFavourite ))
        }else{
            print(#function, "Show Alert that title and description cannot be empty")
        }
    }
    private func addIngredient(){
        if (!self.ingredientName.isEmpty){
            let ingredient = Ingredient( amount: self.ingredientAmount, ingredientName: self.ingredientName)
            self.ingredients.append(ingredient)
            self.ingredientName = ""
            self.ingredientAmount = 0
        }else{
            print(#function, "Show Alert that ingredient name cannot be empty")
        }
        print(#function, "Ingredients: \(self.ingredients)")
    }
    private func addSteps(){
        if (!self.steps.isEmpty){
            self.stepsList.append(self.steps)
            self.steps = ""
        }
        else{
            print(#function, "Show Alert that steps cannot be empty")
        }
        print(#function, "Steps: \(self.steps)")
      }
}//view

//struct AddRecipeView_Previews: PreviewProvider {
 //   static var previews: some View {
  //      AddRecipeView()
  //  }
//}
