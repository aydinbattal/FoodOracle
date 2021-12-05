//
//  Recipe.swift
//  FoodOracle
//
//  Created by Deep on 2021-12-04.
//

import Foundation
import FirebaseFirestoreSwift

struct Recipe: Hashable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var title: String = ""
    var description: String = ""
    var ingredients: String = ""
    var steps: String = ""
    
    init() {
        
    }
    
    init(title: String, description: String, ingredients: String, steps: String) {
        self.title = title
        self.description = description
        self.ingredients = ingredients
        self.steps = steps
    }
    
    
    //initializer used to parse JSON objects into swift object
    init?(dictionary: [String: Any]){
        guard let title = dictionary["title"] as? String else{
            return nil
        }
        
        guard let description = dictionary["description"] as? String else {
            return nil
        }
        
        guard let ingredients = dictionary["ingredients"] as? String else {
            return nil
        }
        
        guard let steps = dictionary["steps"] as? String else {
            return nil
        }
        
        self.init(title: title, description: description, ingredients: ingredients, steps: steps)
    }
}
