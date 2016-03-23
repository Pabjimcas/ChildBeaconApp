//
//  GroupViewController.swift
//  ChildBeaconProject
//
//  Created by mikel balduciel diaz on 17/3/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let beacons = ["Beacon1","Beacon2","Beacon3"]
    var beaconsBD = [Beacon]()
    var group = Int64()
    var datoSeleccionado : Beacon?
    var buttonRow = 0

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        recogerDatos()
        tableView.reloadData()
    }

    //MARK: UITableView delegate methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return beaconsBD.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeaconCell") as! BeaconTableViewCell
        // let group:GroupInfo = marrGroupData.objectAtIndex(indexPath.row) as! GroupInfo
        //cell.btnGroup.setTitle(group.Name, forState: .Normal)
        //cell.btnGroup.setTitle("\(group.Name)", forState: .Normal)
        
        let row = indexPath.row
        cell.nameBeaconLabel.text = beaconsBD[row].name
        cell.editBt.tag = row
        cell.editBt.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    func buttonClicked (sender:UIButton){
        buttonRow = sender.tag
        self.performSegueWithIdentifier("modalUpdateBeaconSegue", sender: self)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.datoSeleccionado = beaconsBD[indexPath.row]
        print("dato: \(self.datoSeleccionado)")
        //self.performSegueWithIdentifier("menuSegue", sender: self)
        
        /*let externalStoryboard = UIStoryboard(name: "GroupsStoryboard", bundle: nil)
        let shoppingListInstance = externalStoryboard.instantiateViewControllerWithIdentifier("shoppingListID") as? ShoopingListViewController
        self.navigationController?.pushViewController(shoppingListInstance!, animated: true)*/
        
    }
    
    func recogerDatos() {
        beaconsBD.removeAll()
        do {
            beaconsBD = try BeaconDataHelper.findAllbyGroup(group)!
        }catch {
            
        }
    }
    @IBAction func updateAction(sender: UIButton) {
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "modalAddBeaconSegue" {
            let destination = segue.destinationViewController as! AddBeaconViewController
            destination.groupId = group
            destination.delegate = self
        }else if segue.identifier == "modalUpdateBeaconSegue" {
            let destination = segue.destinationViewController as! AddBeaconViewController
            destination.groupId = group
            destination.beacon = beaconsBD[buttonRow]
            destination.delegate = self
        }
    }
    


}
