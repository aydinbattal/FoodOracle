//
//  ContentView.swift
//  FoodOracle
//
//  Created by Aydin Battal on 2021-11-22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .top){
                if (self.fireDBHelper.recipeList.count > 0){
                    GeometryReader{_ in
                        Text("Home")
                    }.background(Color("Color").edgesIgnoringSafeArea(.all))
                    SearchBar(data: self.fireDBHelper.recipeList)
                    
                }
            }
        }
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
            }.padding()
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
            .padding()
    }
}

struct Detail : View {
    var data : Recipe
    
    var body : some View{
        Text(data.title)
        Text(data.description)
        Text(data.steps.first ?? "step 1")
    }
}


