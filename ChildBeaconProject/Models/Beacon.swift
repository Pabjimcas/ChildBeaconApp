//
//  KidBeacon
//  Creado por Mikel Balduciel Diaz, Eduardo González de la Huebra Sánchez y David Jiménez Guinaldo en 2016
//  para el Club Universitario de Innovación de la Universidad Pontificia de Salamanca.
//  Copyright © 2016. Todos los derecho reservados.
//

import Foundation
import CoreLocation
class Beacon : NSObject{
    var beaconId = Int64()
    var beaconGroupId = Int64()
    var name = String ()
    var minor = String()
    var major = String()
    var distance = Float()
    var beaconGroupUUID = String()
     dynamic var lastSeenBeacon: CLBeacon?
   
    override
    var hashValue: Int {
        get {
            return beaconId.hashValue << 15 + name.hashValue
        }
    }
    
    static func addBeacon(name: String,minor: String,major: String,group: Int64,groupUUID:String) throws -> Void{
        let beacon = Beacon()
        beacon.name = name
        beacon.beaconGroupId = group
        beacon.minor = minor
        beacon.major = major
        beacon.beaconGroupUUID = groupUUID
        
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
func ==(item: Beacon, beacon: CLBeacon) -> Bool {
    return ((beacon.proximityUUID.UUIDString == item.beaconGroupUUID)
        && (Int(beacon.major) == Int(item.major))
        && (Int(beacon.minor) == Int(item.minor)))
}

func ==(lhs: Beacon, rhs: Beacon) -> Bool {
    return (lhs.beaconId == rhs.beaconId)
        && (lhs.name == rhs.name)
        && (Int(lhs.minor) == Int(rhs.minor))
        && (Int(lhs.major) == Int(rhs.major))
}
