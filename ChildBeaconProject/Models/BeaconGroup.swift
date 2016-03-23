//
//  Ingredient.swift
//  iosAPP
//
//  Created by mikel balduciel diaz on 17/2/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

import Foundation

class BeaconGroup : NSObject {
    var beaconGroupId = Int64()
    var name = String ()
    var UUID = String()
    
    
    static func addBeaconGroup(name: String,uuid: String) throws -> Void{
        let beaconGroup = BeaconGroup()
        beaconGroup.name = name
        beaconGroup.UUID = uuid
        
        do{
            try BeaconGroupDataHelper.insert(beaconGroup)
        } catch{
           throw DataAccessError.Insert_Error
        }
    }
    static func findBeaconGroup (id: Int64) -> BeaconGroup? {
        do {
            return try BeaconGroupDataHelper.find(id)!
        }catch{
            return nil
        }
    }
    /*static func addIngredientStorage(ingredient: Ingredient) throws -> Void{
        ingredient.storageId = 1
        try IngredientDataHelper.insert(ingredient)
    }
    
    static func updateIngredientStorage(ingredient: Ingredient) throws -> Void{
        ingredient.storageId = 1
        try IngredientDataHelper.updateStorage(ingredient)
    }
    
    static func deleteIngredientStorage(ingredient: Ingredient) throws -> Void{
        ingredient.storageId = 0
        try IngredientDataHelper.updateStorage(ingredient)
    }
    
    static func addIngredientCart(ingredient: Ingredient) throws -> Void{
        ingredient.cartId = 1
        try IngredientDataHelper.insert(ingredient)
    }
    
    static func updateIngredientCart(ingredient: Ingredient) throws -> Void{
        ingredient.cartId = 1
        try IngredientDataHelper.updateCart(ingredient)
    }
    
    static func deleteIngredientCart(ingredient: Ingredient) throws -> Void{
        ingredient.cartId = 0
        try IngredientDataHelper.updateCart(ingredient)
    }
    static func stringIngredientsIds(ingredients :[Ingredient]) -> String {
        var ingredientesString = "0"
        if ingredients.count != 0{
            
            for ing in ingredients {
                let io = ing
                let id = String(io.ingredientIdServer)
                ingredientesString  += id  + ",";
            }
        }
        return ingredientesString
    }*/
}
