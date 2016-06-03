//
//  KidBeacon
//  Creado por Mikel Balduciel Diaz, Eduardo González de la Huebra Sánchez y David Jiménez Guinaldo en 2016
//  para el Club Universitario de Innovación de la Universidad Pontificia de Salamanca.
//  Copyright © 2016. Todos los derecho reservados.
//

import UIKit

class GroupViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let beacons = ["Beacon1","Beacon2","Beacon3"]
    var beaconsBD = [Beacon]()
    var group = Int64()
    var groupUUID = String()
    var datoSeleccionado : Beacon?
    var buttonRow = 0
    
    @IBOutlet weak var deleteGroupBt: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if beaconsBD.count <= 0 {
            deleteGroupBt.enabled = true
        }else {
            deleteGroupBt.enabled = false
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        recogerDatos()
        tableView.reloadData()
        if beaconsBD.count <= 0 {
            deleteGroupBt.enabled = true
        }else {
            deleteGroupBt.enabled = false
        }
    }
    
    //MARK: UITableView delegate methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return beaconsBD.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeaconCell") as! BeaconTableViewCell
        
        let row = indexPath.row
        cell.nameBeaconLabel.text = beaconsBD[row].name
        cell.uuidBeaconLabel.text = "major: \(beaconsBD[row].major) minor: \(beaconsBD[row].minor)"
        cell.editBt.tag = row
        cell.editBt.addTarget(self, action: #selector(GroupViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.deleteBt.tag = row
        cell.deleteBt.addTarget(self, action: #selector(GroupViewController.deleteBeacon(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    func buttonClicked (sender:UIButton){
        buttonRow = sender.tag
        self.performSegueWithIdentifier("modalUpdateBeaconSegue", sender: self)
    }
    func deleteBeacon (sender:UIButton){
        buttonRow = sender.tag
        
        do{
            
            try Beacon.deleteBeacon(beaconsBD[buttonRow].beaconId)
            beaconsBD.removeAtIndex(buttonRow)
            if beaconsBD.count < 1 {
                deleteGroupBt.enabled = true
            }
            print("beacon borrado")
            tableView.reloadData()
        }catch {
            
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.datoSeleccionado = beaconsBD[indexPath.row]
        print("dato: \(self.datoSeleccionado)")
        
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
            destination.groupUUID = groupUUID
            destination.delegate = self
        }else if segue.identifier == "modalUpdateBeaconSegue" {
            let destination = segue.destinationViewController as! AddBeaconViewController
            destination.groupId = group
            destination.beacon = beaconsBD[buttonRow]
            destination.delegate = self
        }
    }
    
    @IBAction func deleteGroupAction(sender: UIButton) {
        let beaconGroup = BeaconGroup()
        beaconGroup.beaconGroupId = self.group
        do{
            try BeaconGroupDataHelper.delete(beaconGroup)
            print("grupo borrado")
            navigationController?.popToRootViewControllerAnimated(true)
        }catch {
            
        }
        
    }
    
    
}
