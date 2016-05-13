//
//  ViewController.swift
//  ChildBeaconProject
//
//  Created by mikel balduciel diaz on 17/3/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let datos = ["Platano","Manzana","Mandarina"]
    var datosBD = [BeaconGroup]()
    var datoSeleccionado : Int64!
    var datoSeleccionadoUUID : String!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()        
        initDB()
        crearGrupo()
    }
    
    override func viewWillAppear(animated: Bool) {
        recogerDatos()
        tableView.reloadData()
        
    }
    
    
    func initDB(){
        let dataStore = SQLiteDataStore.sharedInstance
        do{
            try dataStore.createTables()
            
        }catch _ {
            print ("error insert")
        }
        print ("Finish")
    }
    
    func crearGrupo(){
        
        do {
            let grupos = try BeaconGroupDataHelper.findAll()
            if grupos?.count <= 0 {
                let beaconGroup = BeaconGroup()
                beaconGroup.name = "Grupo Default"
                beaconGroup.UUID = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
                try BeaconGroupDataHelper.insert(beaconGroup)
            }
            
        }catch {
            
        }
    }
    
    //MARK: UITableView delegate methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datosBD.count
        
    }
    
   

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GCell") as! MainGroupsTableViewCell
       // let group:GroupInfo = marrGroupData.objectAtIndex(indexPath.row) as! GroupInfo
        //cell.btnGroup.setTitle(group.Name, forState: .Normal)
        //cell.btnGroup.setTitle("\(group.Name)", forState: .Normal)
        
        let row = indexPath.row
        cell.nameLabel.text = datosBD[row].name
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.datoSeleccionado = datosBD[indexPath.row].beaconGroupId
        self.datoSeleccionadoUUID = datosBD[indexPath.row].UUID
        print("dato: \(self.datoSeleccionado)")
        self.performSegueWithIdentifier("menuSegue", sender: self)
        
        /*let externalStoryboard = UIStoryboard(name: "GroupsStoryboard", bundle: nil)
        let shoppingListInstance = externalStoryboard.instantiateViewControllerWithIdentifier("shoppingListID") as? ShoopingListViewController
        self.navigationController?.pushViewController(shoppingListInstance!, animated: true)*/

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "menuSegue") {
            let svc = segue.destinationViewController as! MenuViewController
            svc.groupId = datoSeleccionado
            svc.groupUUID = datoSeleccionadoUUID
        }else if segue.identifier == "modalAddGroupSegue" {
            let destination = segue.destinationViewController as! AddGroupViewController
            destination.delegate = self
        }
    }
    func recogerDatos() {
        datosBD.removeAll()
        do {
           datosBD = try BeaconGroupDataHelper.findAll()!
        }catch {
            
        }
    }
    

}

