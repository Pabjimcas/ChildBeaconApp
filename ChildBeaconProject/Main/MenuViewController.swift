//
//  MenuViewController.swift
//  ChildBeaconProject
//
//  Created by mikel balduciel diaz on 17/3/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    var groupId : Int64!
    var groupUUID : String!



    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "groupVCSegue" {
            let destination = segue.destinationViewController as! GroupViewController
            destination.group = groupId
            destination.groupUUID = groupUUID

        }else if segue.identifier == "rastreatorSegue"  {
            let tabBarController = segue.destinationViewController as! UITabBarController
            let destination = tabBarController.viewControllers![0] as! BeaconsListViewController
            destination.group = groupId
            destination.groupUUID = groupUUID
        }
    }
}
