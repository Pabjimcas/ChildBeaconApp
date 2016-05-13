//
//  BeaconsListViewController.swift
//  ChildBeaconProject
//
//  Created by mikel balduciel diaz on 9/5/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

import UIKit
import CoreLocation
class BeaconsListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    var items: [Beacon] = []
    var group : Int64!
    var groupUUID : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.allowsBackgroundLocationUpdates = true
        loadItems()
    }
    override func viewWillDisappear(animated: Bool) {
        print("atras")
        for beacon in items {
            stopMonitoringItem(beacon)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadItems() {
        do {
            let tempItems = try  BeaconDataHelper.findAllbyGroup(group)!
            for beacon in tempItems {
                items.append(beacon)
                startMonitoringItem(beacon)
            }
        }catch{
            
        }
        
    }
    func beaconRegionWithItem(item:Beacon) -> CLBeaconRegion {
        let majorBeacon = CLBeaconMajorValue(item.major)!
        let minorBeacon = CLBeaconMinorValue(item.minor)!
        let groupUUIDObject = NSUUID(UUIDString: groupUUID)
        let beaconRegion = CLBeaconRegion(proximityUUID: groupUUIDObject!,
                                          major: majorBeacon,
                                          minor: minorBeacon,
                                          identifier: item.name)
        return beaconRegion
    }
    
    func startMonitoringItem(item: Beacon) {
        let beaconRegion = beaconRegionWithItem(item)
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringForRegion(beaconRegion)
        
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        
    }
    func stopMonitoringItem(item: Beacon) {
        let beaconRegion = beaconRegionWithItem(item)
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringForRegion(beaconRegion)
        locationManager.stopRangingBeaconsInRegion(beaconRegion)
    }
}
// MARK: UITableViewDataSource
extension BeaconsListViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeaconCell", forIndexPath: indexPath) as! BeaconRastreatorTableViewCell
        let item = items[indexPath.row]
        cell.item = item
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let itemToRemove = items[indexPath.row] as Beacon
            stopMonitoringItem(itemToRemove)
            tableView.beginUpdates()
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.endUpdates()
            // persistItems()
        }
    }
}

// MARK: UITableViewDelegate
extension BeaconsListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let item = items[indexPath.row] as Beacon
        let uuid = groupUUID
        let detailMessage = "UUID: \(uuid)\nMajor: \(item.major)\nMinor: \(item.minor)"
        let detailAlert = UIAlertController(title: "Details", message: detailMessage, preferredStyle: .Alert)
        detailAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(detailAlert, animated: true, completion: nil)
    }
}
// MARK: - CLLocationManagerDelegate

extension BeaconsListViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        print("Failed monitoring region: \(error.description)")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location manager failed: \(error.description)")
    }
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if let beacons = beacons as? [CLBeacon] {
            for beacon in beacons {
                for item in items {
                    if item == beacon {
                        item.lastSeenBeacon = beacon
                    }                }
            }
        }
    }
    
    
}

