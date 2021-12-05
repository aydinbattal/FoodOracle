//
//  Recipe.swift
//  FoodOracle
//
//  Created by Deep on 2021-12-04.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct Recipe: Hashable, Codable, Identifiable{
    @DocumentID var id: String? = UUID().uuidString
    var title: String = ""
    var description: String = ""
    var ingredients: [Ingredient] = []
    var steps: String = ""
    var isFavourite: Bool = false
    //var test: [String] = []
    
    init() {
        
    }
    
    init(title: String, description: String, ingredients: [Ingredient], steps: String, isFavourite: Bool) {
        self.title = title
        self.description = description
        self.ingredients = ingredients
        self.steps = steps
        self.isFavourite = isFavourite
    }
    
    
    //initializer used to parse JSON objects into swift object
    init?(dictionary: [String: Any]){
        guard let title = dictionary["title"] as? String else{
            return nil
        }
        
        guard let description = dictionary["description"] as? String else {
            return nil
        }
        
        guard let ingredients = dictionary["ingredients"] as? [Ingredient] else {
            return nil
        }
        
        guard let steps = dictionary["steps"] as? String else {
            return nil
        }
        
        guard let isFavourite = dictionary["isFavourite"] as? Bool else {
            return nil
        }
        
        self.init(title: title, description: description, ingredients: ingredients, steps: steps, isFavourite: isFavourite)
    }
}
