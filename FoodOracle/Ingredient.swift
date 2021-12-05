//
//  Ingredient.swift
//  FoodOracle
//
//  Created by Deep on 2021-12-04.
//

import Foundation

struct Ingredient: Hashable, Codable{
    var id = UUID()
    var amount: Int = 0
    var ingredientName: String = ""
    
    init() {
    }
    
    init(amount: Int, ingredientName: String) {        
        self.amount = amount
        self.ingredientName = ingredientName
    }
    
}
