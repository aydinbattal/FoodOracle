//
//  ContentView.swift
//  FoodOracle
//
//  Created by Aydin Battal, Karan Patel, Deep Patel
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var selection: Int? = nil
    init(){UITableView.appearance().backgroundColor = .clear
           UITableViewCell.appearance().backgroundColor = .clear
           let navBarAppearance = UINavigationBar.appearance()
                      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
       }
    var body: some View {
    GeometryReader{ geometry in
                
        NavigationView{
       
            ZStack(alignment: .top){
                Image("blurfoodbg").resizable()
                                    .aspectRatio(geometry.size, contentMode: .fill)
                                    .edgesIgnoringSafeArea(.all)
                NavigationLink(destination: AddRecipeView(), tag: 1, selection: $selection){}
                NavigationLink(destination: NearbyPlacesView(), tag: 2, selection: $selection){}
                if (self.fireDBHelper.recipeList.count > 0){
                    List{
                        
                        Section(header: Text("Favourites")){
                            ForEach (self.fireDBHelper.recipeList.enumerated().map({$0}), id: \.element.self){ indx, currentRecipe in
                                
                                if (currentRecipe.isFavourite){
                                    NavigationLink(destination: RecipeDetailView(selectedRecipeIndex: indx)){
                                        VStack(alignment: .leading){
                                            Text("\(currentRecipe.title)")
                                                .fontWeight(.bold)
                                        }.padding()
                                            .onTapGesture {
                                                print("\(self.fireDBHelper.recipeList[indx].title) selected")
                                            }
                                    }//NavigationLink
                                }//if for favourite
                            }//ForEach
                            .onDelete(perform: {indexSet in
                                for index in indexSet{
                                    //ask for confirmation and then delete
                                    self.fireDBHelper.deleteRecipe(recipeToDelete: self.fireDBHelper.recipeList[index])
                                }
                            })
                        }
                        
                        Section(header: Text("All Recipes")){
                            ForEach (self.fireDBHelper.recipeList.enumerated().map({$0}), id: \.element.self){ indx, currentRecipe in
                                NavigationLink(destination: RecipeDetailView(selectedRecipeIndex: indx)){
                                    VStack(alignment: .leading){
                                        Text("\(currentRecipe.title)")
                                            .fontWeight(.bold)
                                    }.padding()
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
                        }//Section for all recipes
                    }//List
                    .padding()
                    .offset(y:30)
                    .frame(width: UIScreen.main.bounds.size.width, height: 585, alignment: .top)
                    
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
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                SearchBar(data: self.fireDBHelper.recipeList)
                
                
            }//zstack
     
            .navigationBarTitle("Food Oracle")
            .navigationBarItems(trailing: Button("Add New Recipe", action: {
                self.selection = 1
            }))
        }//navigation view
    }//geometry reader
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
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .padding(.bottom, 15)
                if (self.tfSearch != ""){
                    Button(action: {
                        self.tfSearch = ""
                    }) {
                        Text("Cancel")
                            .padding(.trailing, 15)
                            .padding(.bottom, 15)
                    }
                    .foregroundColor(.black)
                }
            }
            if (self.tfSearch != ""){
                if (self.data.filter({$0.title.lowercased().contains(self.tfSearch.lowercased())}).count == 0){
//                    Text("No Results Found")
                } else {
                    List(self.data.filter{$0.title.lowercased().contains(self.tfSearch.lowercased())}){i in
                        
                        NavigationLink(destination: Detail(data: i)){
                            Text(i.title)
                        }
                    }.frame(height: 550)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .padding(.top, 0)
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
         
        }//VStack
    }
}


