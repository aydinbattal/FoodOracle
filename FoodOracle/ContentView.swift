//
//  ContentView.swift
//  FoodOracle
//
//  Created by Aydin Battal on 2021-11-22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var selection: Int? = nil
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom){
                NavigationLink(destination: AddRecipeView(), tag: 1, selection: $selection){}
                NavigationLink(destination: MapView(), tag: 2, selection: $selection){}
                if (self.fireDBHelper.recipeList.count > 0){
                    List{
                        SearchBar(data: self.fireDBHelper.recipeList)
                        ForEach (self.fireDBHelper.recipeList.enumerated().map({$0}), id: \.element.self){ indx, currentRecipe in
                            NavigationLink(destination: RecipeDetailView(selectedRecipeIndex: indx)){
                                VStack(alignment: .leading){
                                    Text("\(currentRecipe.title)")
                                        .fontWeight(.bold)
                                }.padding(20)
                                    .onTapGesture {
                                        print("\(self.fireDBHelper.recipeList[indx].title) selected")
                                    }
                            }//NavigationLink
                        }//ForEach
                        .onDelete(perform: {indexSet in
                            for index in indexSet{
                                //ask for confirmation and then delete
                                self.fireDBHelper.deleteRecipe(recipeToDelete: self.fireDBHelper.recipeList[index])
                            }
                        })
                    }//List
                    
                }//if
                else{
                    VStack{
                        Text("No recipes in the database")
                        Spacer()
                    }
                }//else
                Button(action: {
                    print("Add recipe")
                    self.selection = 2
                }){
                    Text("Dont feel like cooking?")
                        .fontWeight(.bold)
                        .modifier(AppButtonTextModifier())
                }//Button
                .modifier(AppButtonModifier())
            }//zstack
            .navigationBarTitle("Recipe List")
            .navigationBarItems(trailing: Button("Add New Recipe", action: {
                self.selection = 1
            }))
        }//navigation view
        
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            self.fireDBHelper.getAllRecipes()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchBar: View {
    @State var tfSearch = ""
    var data : [Recipe]
    
    var body : some View {
        VStack(spacing: 0){
            HStack{
                TextField("Search", text: self.$tfSearch)
                if (self.tfSearch != ""){
                    Button(action: {
                        self.tfSearch = ""
                    }) {
                        Text("Cancel")
                    }
                    .foregroundColor(.black)
                }
            }
            if (self.tfSearch != ""){
                if (self.data.filter({$0.description.lowercased().contains(self.tfSearch.lowercased())}).count == 0){
                    Text("No Results Found")
                        .foregroundColor(Color.black.opacity(0.5).padding() as? Color)
                } else {
                    List(self.data.filter{$0.description.lowercased().contains(self.tfSearch.lowercased())}){i in
                        
                        NavigationLink(destination: Detail(data: i)){
                            Text(i.title)
                        }
                    }.frame(height: UIScreen.main.bounds.height/5)
                }
            }
        }.background(Color.white)
    }
}

struct Detail : View {
    var data : Recipe
    
    var body : some View{
        VStack{
            Text(data.title)
                .autocapitalization(.words)
                .font(.title)
                .padding(25)
            Form{
                Section(header: Text("Description")){
                Text(data.description)
                    .autocapitalization(.words)
                }
                
                Section(header: Text("Ingredients")){
                    ForEach(data.ingredients, id: \.self){ Ingredient in
                        HStack{
                            Text(String(Ingredient.amount))
                            Text(Ingredient.ingredientName)
                        }
                    }//foreach
                }//section for ingredients
                
                Section(header: Text("Steps")){
                    ForEach(data.steps, id: \.self){ step in
                        Text(step)
                    }
                }//section for steps
            }//Form
            Spacer()
        }//VStack
    }
}


