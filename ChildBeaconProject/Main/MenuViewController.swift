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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "groupVCSegue" {
            let destination = segue.destinationViewController as! GroupViewController
            destination.group = groupId

        }else if segue.identifier == "rastreatorSegue"  {
            let tabBarController = segue.destinationViewController as! UITabBarController
            let destination = tabBarController.viewControllers![0] as! ListBeaconsRastreatorViewController
            destination.group = groupId
        }
    }
}
