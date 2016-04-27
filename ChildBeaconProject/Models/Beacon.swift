//
//  Ingredient.swift
//  iosAPP
//
//  Created by mikel balduciel diaz on 17/2/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

import Foundation

class Beacon : NSObject{
    var beaconId = Int64()
    var beaconGroupId = Int64()
    var name = String ()
    var minor = String()
    var major = String()
    var distance = Float()
   
    override
    var hashValue: Int {
        get {
            return beaconId.hashValue << 15 + name.hashValue
        }
    }
    
    static func addBeacon(name: String,minor: String,major: String,group: Int64) throws -> Void{
        let beacon = Beacon()
        beacon.name = name
        beacon.beaconGroupId = group
        beacon.minor = minor
        beacon.major = major
        
        do{
            try BeaconDataHelper.insert(beacon)
        } catch{
           throw DataAccessError.Insert_Error
        }
    }
    static func updateBeacon(id : Int64, name: String,minor: String,major: String) throws -> Void{
        let beacon = Beacon()
        beacon.beaconId = id
        beacon.name = name
        beacon.minor = minor
        beacon.major = major
        do{
            try BeaconDataHelper.updateBeacon(beacon)
        } catch{
            throw DataAccessError.Insert_Error
        }
    }
    static func deleteBeacon(id : Int64) throws -> Void{
        let beacon = Beacon()
        beacon.beaconId = id
        
        do{
            try BeaconDataHelper.delete(beacon)
        } catch{
            throw DataAccessError.Delete_Error
        }
    }

}
func ==(lhs: Beacon, rhs: Beacon) -> Bool {
    return lhs.beaconId == rhs.beaconId && lhs.name == rhs.name
}
