//
//  FireDBHelper.swift
//  FoodOracle
//
//Deep Patel - 991584445, Karan Patel - 991519115, Aydin Battal - 991521740
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
        do{
            
            try self.store.collection(COLLECTION_NAME).addDocument(from: newRecipe)
            
            print(#function, "Doc succesfully added to Firestore")
        }catch let error as NSError{
            print(#function, "Error while inserting document on firestore", error)
        }
    }
    
    func getAllRecipes(){
        self.store.collection(COLLECTION_NAME)
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
        self.store.collection(COLLECTION_NAME)
            .document(recipeToUpdate.id!)
            .updateData(["title" : recipeToUpdate.title, "description": recipeToUpdate.description, "ingredients": recipeToUpdate.ingredients, "steps": recipeToUpdate.steps, "favourite": recipeToUpdate.isFavourite]){ error in
                if let error = error{
                    print(#function, "Error while updating doc \(error)")
                }else{
                    print(#function, "Successfully updated doc")
                }
            }
    }
    
    func deleteRecipe(recipeToDelete: Recipe){
        self.store.collection(COLLECTION_NAME)
            .document(recipeToDelete.id!)
            .delete{ error in
                if let error = error{
                    print(#function, "Error while deleteing doc \(error)")
                }else{
                    print(#function, "Successfully deleted doc")
                }
            }
    }
    
    func searchRecipe(recipeToSearch: Recipe){
        //self.store.collection(COLLECTION_NAME)
    }
    
}
