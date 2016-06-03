//
//  KidBeacon
//  Creado por Mikel Balduciel Diaz, Eduardo González de la Huebra Sánchez y David Jiménez Guinaldo en 2016
//  para el Club Universitario de Innovación de la Universidad Pontificia de Salamanca.
//  Copyright © 2016. Todos los derecho reservados.
//

import UIKit
import CoreLocation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let locationManager = CLLocationManager()
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        locationManager.delegate = self
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Sound, .Alert], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        return true
    }
    
    
}
// MARK: - CLLocationManagerDelegate
extension AppDelegate: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if let beacons = beacons as? [CLBeacon] {
            for beacon in beacons {
                print("Hola")
            }
        }
    }
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let beaconRegion = region as? CLBeaconRegion {
           print(beaconRegion.proximityUUID)
            let notification = UILocalNotification()
            notification.alertBody = "Are you forgetting something? major: \(beaconRegion.major) minor: \(beaconRegion.minor)"
            notification.soundName = "Default"
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        }
    }

}

