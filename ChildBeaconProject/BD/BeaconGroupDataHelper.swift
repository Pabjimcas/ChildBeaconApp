//
//  IngredientDataHelper.swift
//  iosAPP
//
//  Created by mikel balduciel diaz on 17/2/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

import Foundation
import SQLite

class BeaconGroupDataHelper: DataHelperProtocol {
    static let TABLE_NAME = "BeaconsGroups"
    
    static let table = Table(TABLE_NAME)
   // let storage = Table("users")
    static let beaconGroupId = Expression<Int64>("beaconGroupId")
    static let name = Expression<String>("name")
    static let uuid = Expression<String>("UUID")
    typealias T = BeaconGroup
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            let _ = try DB.run(table.create(temporary: false, ifNotExists: true) { t in
                t.column(beaconGroupId, primaryKey: true)
                t.column(name, unique: true)
                t.column(uuid, unique: true)
               
               
                })
        }catch _ {
            print("error create table")
        }
    }
    static func insert (item: T) throws -> Int64 {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let insert = table.insert(name <- item.name,uuid <- item.UUID)
            do {
                let rowId = try DB.run(insert)
                guard rowId > 0 else {
                    throw DataAccessError.Insert_Error
                }
                return rowId
            }catch _ {
                throw DataAccessError.Insert_Error
            }
    }
    
    static func delete (item: T) throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
            let query = table.filter(beaconGroupId == item.beaconGroupId)
            do {
                let tmp = try DB.run(query.delete())
                guard tmp == 1 else {
                    throw DataAccessError.Delete_Error
                }
            } catch _ {
                throw DataAccessError.Delete_Error
            }
    }
    
   /* static func updateStorage (item: T) throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }

        let query = table.filter(ingredientId == item.ingredientId)
        do {
            let tmp = try DB.run(query.update(storageId <- item.storageId))
            guard tmp == 1 else {
                throw DataAccessError.Delete_Error
            }
        } catch _ {
            throw DataAccessError.Delete_Error
        }
    }
    static func updateCart (item: T) throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        let query = table.filter(ingredientId == item.ingredientId)
        do {
            let tmp = try DB.run(query.update(cartId <- item.cartId))
            guard tmp == 1 else {
                throw DataAccessError.Delete_Error
            }
        } catch _ {
            throw DataAccessError.Delete_Error
        }
    }
    
    static func findIngredientsInStorage () throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        let query = table.filter(storageId == 1)
        var retArray = [T]()
        let items = try DB.prepare(query)
        for item in items {
            let ingredient = Ingredient()
            ingredient.ingredientId = item[ingredientId]
            ingredient.ingredientIdServer = item[ingredientIdServer]
            ingredient.name = item[name]
            ingredient.baseType = item[baseType]
            ingredient.category = item[category]
            ingredient.frozen = FrozenTypes(rawValue: item[frozen])!
            ingredient.storageId = item[storageId]
            ingredient.cartId = item[cartId]
            retArray.append(ingredient)
        }
        return retArray
    }
    static func findIngredientsNotInStorage () throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        let query = table.filter(storageId != 1)
        var retArray = [T]()
        let items = try DB.prepare(query)
        for item in items {
            let ingredient = Ingredient()
            ingredient.ingredientId = item[ingredientId]
            ingredient.ingredientIdServer = item[ingredientIdServer]
            ingredient.name = item[name]
            ingredient.baseType = item[baseType]
            ingredient.category = item[category]
            ingredient.frozen = FrozenTypes(rawValue: item[frozen])!
            ingredient.storageId = item[storageId]
            ingredient.cartId = item[cartId]
            retArray.append(ingredient)
        }
        return retArray
    }
    static func findIngredientsNotInStorageCart () throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        let query = table.filter(storageId != 1)
        let query2 = query.filter(cartId != 1)
        var retArray = [T]()
        let items = try DB.prepare(query2)
        for item in items {
            let ingredient = Ingredient()
            ingredient.ingredientId = item[ingredientId]
            ingredient.ingredientIdServer = item[ingredientIdServer]
            ingredient.name = item[name]
            ingredient.baseType = item[baseType]
            ingredient.category = item[category]
            ingredient.frozen = FrozenTypes(rawValue: item[frozen])!
            ingredient.storageId = item[storageId]
            ingredient.cartId = item[cartId]
            retArray.append(ingredient)
        }
        return retArray
    }
    
    static func findIngredientsInCart () throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        let query = table.filter(cartId == 1)
        var retArray = [T]()
        let items = try DB.prepare(query)
        for item in items {
            let ingredient = Ingredient()
            ingredient.ingredientId = item[ingredientId]
            ingredient.ingredientIdServer = item[ingredientIdServer]
            ingredient.name = item[name]
            ingredient.baseType = item[baseType]
            ingredient.category = item[category]
            ingredient.frozen = FrozenTypes(rawValue: item[frozen])!
            ingredient.storageId = item[storageId]
            ingredient.cartId = item[cartId]
            retArray.append(ingredient)
        }
        return retArray
    }*/

    static func find(id: Int64) throws -> T? {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(beaconGroupId == id)
        let items = try DB.prepare(query)
        for item in  items {
            let beaconGroup = BeaconGroup()
            beaconGroup.beaconGroupId = item[beaconGroupId]
            beaconGroup.name = item[name]
            beaconGroup.UUID = item[uuid]
           
            return beaconGroup
        }
        
        return nil
        
    }
    
    /*static func findIdServer(id: Int64) throws -> T? {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(ingredientIdServer == id)
        let items = try DB.prepare(query)
        for item in  items {
            let ingredient = Ingredient()
            ingredient.ingredientId = item[ingredientId]
            ingredient.ingredientIdServer = item[ingredientIdServer]
            ingredient.name = item[name]
            ingredient.baseType = item[baseType]
            ingredient.category = item[category]
            ingredient.frozen = FrozenTypes(rawValue: item[frozen])!
            ingredient.storageId = item[storageId]
            ingredient.cartId = item[cartId]
            return ingredient
        }
        
        return nil
        
    }*/
    
    static func findAll() throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.DB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        let items = try DB.prepare(table)
        for item in items {
            let beaconGroup = BeaconGroup()
            beaconGroup.beaconGroupId = item[beaconGroupId]
            beaconGroup.name = item[name]
            beaconGroup.UUID = item[uuid]
            retArray.append(beaconGroup)
        }
        
        return retArray
        
    }
}