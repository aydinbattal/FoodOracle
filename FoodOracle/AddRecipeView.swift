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
    @State private var steps: String = ""
    @State private var title: String = ""
    @State private var isFavourite: Bool = false
  
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    var body: some View {
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
              
                
                TextField("Enter Steps", text: self.$steps)
                    .autocapitalization(.words)
                
                Toggle(isOn: self.$isFavourite, label: {
                    Text("Favourite")
                })
                
            }//Form
            
            Button(action: {
                self.addNewRecipe()
              
            }){
                Text("Add Recipie")
                
            }
            
            Spacer()
        }//VStack
    }//body
    private func addNewRecipe(){
        var listOfIngredients = [Ingredient]()
        listOfIngredients.append(Ingredient(amount: self.ingredientAmount, ingredientName: self.ingredientName))
        var listOfSteps = [String]()
        listOfSteps.append(String(steps))
        print("Adding recipe to database")
        if (!self.title.isEmpty && !self.description.isEmpty){
            //add to database
            self.fireDBHelper.addRecipe(newRecipe: Recipe(title: self.title, description: self.description, ingredients: listOfIngredients, steps: listOfSteps, isFavourite: self.isFavourite ))
        }else{
            print(#function, "Show Alert that title and description cannot be empty")
        }
    }
}//view

//struct AddRecipeView_Previews: PreviewProvider {
 //   static var previews: some View {
  //      AddRecipeView()
  //  }
//}
