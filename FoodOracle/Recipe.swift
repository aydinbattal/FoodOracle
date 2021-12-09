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
//    var vegetables: String = ""
//    var dairy: String = ""
//    var fruits: String = ""
//    var proteins: String = ""
    var steps: [String] = []
    //var steps: String = ""
    var isFavourite: Bool = false
    //var test: [String] = []
    
    init() {
        
    }
    
    init(title: String, description: String, ingredients: [Ingredient], steps: [String], isFavourite: Bool) {
        self.title = title
        self.description = description
        self.ingredients = ingredients
        self.steps = steps
        self.isFavourite = isFavourite
    }
    
//    init(title: String, description: String, vegetables: String , dairy: String, fruits: String, proteins: String, steps: String, isFavourite: Bool) {
//        self.title = title
//        self.description = description
//        self.vegetables = vegetables
//        self.dairy = dairy
//        self.fruits = fruits
//        self.proteins = proteins
//        self.steps = steps
//        self.isFavourite = isFavourite
//    }
    
    
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
        
//        guard let vegetables = dictionary["vegetables"] as? String else {
//            return nil
//        }
//        guard let dairy = dictionary["dairy"] as? String else {
//            return nil
//        }
//        guard let fruits = dictionary["fruits"] as? String else {
//            return nil
//        }
//        guard let proteins = dictionary["proteins"] as? String else {
//            return nil
//        }
        
        guard let steps = dictionary["steps"] as? [String] else {
            return nil
        }
        
//        guard let steps = dictionary["steps"] as? String else {
//            return nil
//        }
        
        guard let isFavourite = dictionary["isFavourite"] as? Bool else {
            return nil
        }
        
        self.init(title: title, description: description, ingredients: ingredients, steps: steps, isFavourite: isFavourite)
    }
}
