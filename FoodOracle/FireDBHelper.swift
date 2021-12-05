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
        self.store.collection(COLLECTION_NAME)
            .whereField("MyRecipies", isEqualTo: true)
            .order(by: "title", descending: true)
            .addSnapshotListener({(querySnapshot, error) in
                guard let snapshot = querySnapshot else{
                    print(#function, "Error getting the snapshot from listener", error as Any)
                    return
                }
                
                //no error
                snapshot.documentChanges.forEach{ (docChange) in
                    
                    var recipe = Recipe()
                    
                    do{
                        recipe = try docChange.document.data(as: Recipe.self)!
                        let docId = docChange.document.documentID
                        let matchedIndex = self.recipeList.firstIndex(where: {($0.id?.elementsEqual(docId))!})
                        
                        if docChange.type == .added{
                            self.recipeList.append(recipe)
                            print(#function, "New Dc Added " , recipe)
                        }
                        
                        if docChange.type == .modified{
                            if (matchedIndex != nil){
                                self.recipeList[matchedIndex!] = recipe
                            }
                        }
                        
                        if docChange.type == .removed{
                            if (matchedIndex != nil){
                                self.recipeList.remove(at: matchedIndex!)
                            }
                        }
                        
                    }catch let error as NSError{
                        print(#function, "Error while retrieving doc change", error)
                    }
                }
                
            })
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
