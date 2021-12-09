//
//  ContentView.swift
//  FoodOracleWatch WatchKit Extension
//
//  Created by Aydin Battal on 2021-12-08.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fireDbHelper : FireDBHelper
    
    var body: some View {
        List(self.fireDbHelper.recipeList.filter{$0.description.lowercased().contains(self.tfSearch.lowercased())}){i in
            NavigationLink(destination: Detail(data: i)){
                Text(i.title)
            }
        }
    }
        .onAppear(){
            self.fireDBHelper.getAllRecipes()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Detail : View {
    var data : Recipe
    
    var body : some View{
        Text(data.title)
        Text(data.description)
    }
}
