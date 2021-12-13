//
//  Ingredient.swift
//  FoodOracle
//
//Deep Patel - 991584445, Karan Patel - 991519115, Aydin Battal - 991521740
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
