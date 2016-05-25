//
//  AppDelegate.swift
//  ChildBeaconProject
//
//  Created by mikel balduciel diaz on 17/3/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
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
    
    /* func applicationWillResignActive(application: UIApplication) {
     do{
     let notificaciones = try NotificationsDataHelper.findAll()
     application.applicationIconBadgeNumber =  (notificaciones?.count)!
     }catch _ {
     print("error al mostrar notificaciones")
     }
     }
     func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
     let id = notification.userInfo!["uid"]
     let noti = Notification()
     noti.notificationId = Int64(id! as! Int)
     do{
     let notificationSearch = try NotificationsDataHelper.find(noti.notificationId)
     if notificationSearch != nil {
     try NotificationsDataHelper.delete(noti)
     }
     } catch _ {
     print ("error al borrar notificacion")
     }
     }
     func applicationWillEnterForeground(application: UIApplication) {
     do {
     let notifications = try NotificationsDataHelper.findAll()! as [Notification]
     for noti in notifications {
     let noti2 = noti as Notification
     let now = NSDate()
     if now.compare(noti.firedate) == NSComparisonResult.OrderedDescending || now.compare(noti.firedate) == NSComparisonResult.OrderedSame {
     do{
     try NotificationsDataHelper.delete(noti2)
     } catch _ {
     print ("error al borrar notificacion")
     }
     }
     }
     }catch _ {
     
     }
     
     }*/
    
    
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
            notification.alertBody = "Se ha perdido el contacto con el bacon con major: \(beaconRegion.major) y minor: \(beaconRegion.minor)"
            notification.soundName = "Default"
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        }
    }

}

