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
}
