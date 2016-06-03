//
//  KidBeacon
//  Creado por Mikel Balduciel Diaz, Eduardo González de la Huebra Sánchez y David Jiménez Guinaldo en 2016
//  para el Club Universitario de Innovación de la Universidad Pontificia de Salamanca.
//  Copyright © 2016. Todos los derecho reservados.
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
