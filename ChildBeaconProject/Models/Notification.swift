//
//  KidBeacon
//  Creado por Mikel Balduciel Diaz, Eduardo González de la Huebra Sánchez y David Jiménez Guinaldo en 2016
//  para el Club Universitario de Innovación de la Universidad Pontificia de Salamanca.
//  Copyright © 2016. Todos los derecho reservados.
//

import Foundation

extension NSDate {
    class var declaredDatatype: String {
        return String.declaredDatatype
    }
    class func fromDatatypeValue(stringValue: String) -> NSDate {
        return SQLDateFormatter.dateFromString(stringValue)!
    }
    var datatypeValue: String {
        return SQLDateFormatter.stringFromDate(self)
    }
}

let SQLDateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
    
    return formatter
}()

class Notification: NSObject {
    var notificationId = Int64()
    var firedate = NSDate()
    var beaconId = Int64()
   // var taskId = Int64()
    
    /*static func findNotification(task:Task) -> Notification?{
        var currentNotification : Notification?
        do{
            if let dso = try NotificationsDataHelper.findNotificationByTask((task.taskIdServer)){
                currentNotification = dso
                
            }
        }catch _{
            print("Error al encontrar Notification")
        }
        return currentNotification
        
    }*/
}