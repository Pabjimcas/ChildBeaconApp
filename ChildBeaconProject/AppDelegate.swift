//
//  AppDelegate.swift
//  ChildBeaconProject
//
//  Created by mikel balduciel diaz on 17/3/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      //  if application.respondsToSelector("registerUserNotificationSettings:") {
            //if #available(iOS 8.0, *) {
                let types:UIUserNotificationType = ([.Alert, .Sound, .Badge])
                let settings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
                application.registerUserNotificationSettings(settings)
                application.registerForRemoteNotifications()
          //  } else {
            //    application.registerForRemoteNotificationTypes([.Alert, .Sound, .Badge])
            //}
       // }
       // else {
            // Register for Push Notifications before iOS 8
         //   application.registerForRemoteNotificationTypes([.Alert, .Sound, .Badge])
        //}
        return true
    }
    func applicationWillResignActive(application: UIApplication) {
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
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

