//
//  FireDBHelper.swift
//  FoodOracle
//
//  Created by Deep on 2021-12-04.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    @Published var recipeList = [Recipe]()
    private let store: Firestore
    private let COLLECTION_NAME: String = "MyRecipes"
    
    //singleton instance
    private static var shared: FireDBHelper?
    
    static func getInstance() -> FireDBHelper{
        if shared == nil{
            shared = FireDBHelper(database: Firestore.firestore())
        }
        return shared!
    }
    
    init(database: Firestore) {
        self.store = database
    }
    
    func addRecipe(newRecipe: Recipe){
        //self.store.collection(COLLECTION_NAME)
    }
    
    func getAllRecipes(){
        //self.store.collection(COLLECTION_NAME)
    }
    
    func updateRecipe(recipeToUpdate: Recipe){
        //self.store.collection(COLLECTION_NAME)
    }
    
    func deleteRecipe(recipeToDelete: Recipe){
        //self.store.collection(COLLECTION_NAME)
    }
    
    func searchRecipe(recipeToSearch: Recipe){
        //self.store.collection(COLLECTION_NAME)
    }
    
}
