//
//  ListBeaconsRastreatorViewController.swift
//  ChildBeaconProject
//
//  Created by mikel balduciel diaz on 17/3/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

/*import UIKit
import CoreLocation
class ListBeaconsRastreatorViewController: UIViewController,CLLocationManagerDelegate{
    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    var beaconGroup :BeaconGroup?
    var beaconsArray = [Beacon]()
    var mostrar = true
    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
    
    var group : Int64!
    /*let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "RadBeacon Mikel")*/
    var region : CLBeaconRegion!
    override func viewDidLoad() {
        super.viewDidLoad()
        let accion = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default) { _ in self.alert.dismissViewControllerAnimated(true, completion: {
            self.mostrar = true
        })}
        alert.addAction(accion)
        
    }
    
    func getGroup(id:Int64){
        beaconGroup = BeaconGroup.findBeaconGroup(id)
        if beaconGroup != nil {
            var uuid = ""
            uuid = (beaconGroup?.UUID)!
            let name = beaconGroup?.name
            let nsuuid = NSUUID(UUIDString: uuid)!
            region = CLBeaconRegion(proximityUUID: nsuuid, identifier: name!)
            rellenarSet()
            initLocation()
        }
        
    }
    func initLocation(){
        locationManager.delegate=self
        
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
            
        }
        locationManager.allowsBackgroundLocationUpdates = true
        
        locationManager.startRangingBeaconsInRegion(region)

    }
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion){
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if knownBeacons.count > 0 {
            for closestBeacon in knownBeacons {
                
                let minor = closestBeacon.minor.stringValue
                let major = closestBeacon.major.stringValue

                do {
                    let beaconBD = try BeaconDataHelper.find((beaconGroup?.beaconGroupId)!, minorValue: minor, majorValue:major)
                    
                    if beaconBD != nil {
                        for (index, item) in beaconsArray.enumerate(){
                            if item.minor == "\(closestBeacon.minor)" && item.major == "\(closestBeacon.major)" {
                                item.distance = Float(closestBeacon.accuracy)
                                beaconsArray[index] = item
                                var codigo = -1 //Código para identificar el tipo de notificación
                                if closestBeacon.accuracy > 1{
                                    print("\(mostrar)")
                                    if (mostrar){
                                        presentViewController(alert, animated: true, completion: nil)
                                        mostrar = false
                                    }
                                    
                                    codigo = 0
                                  let id = guardarNotificacion(item.beaconId)
                                    EnviarNotificacion(codigo,nombre: (beaconBD?.name)!,id: id)
                                    
                                }else{
                                    mostrar = true
                                    codigo = 1
                                    //EnviarNotificacion(codigo,nombre: (beaconBD?.name)!)
                                    
                                }
                                self.tableView.reloadData()
                            }
                        }
                        
                    }
                    
                }catch {
                    print("no se ha encontrado el beacon en el grupo")
                }
                

            }
            
        }
        else {
            //nombre.text = ""
            //cajatexto.text = "no se encuentran dispositivos"
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getGroup(group)
        self.locationManager.startRangingBeaconsInRegion(self.region)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.locationManager.stopRangingBeaconsInRegion(self.region)
    }
    
    
    //MARK: UITableView delegate methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return beaconsArray.count
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeaconCell") as! BeaconRastreatorTableViewCell
        // let group:GroupInfo = marrGroupData.objectAtIndex(indexPath.row) as! GroupInfo
        //cell.btnGroup.setTitle(group.Name, forState: .Normal)
        //cell.btnGroup.setTitle("\(group.Name)", forState: .Normal)
        
        let row = indexPath.row
        cell.nameLabel.text = beaconsArray[row].name
        cell.accuracyLabel.text = "\(beaconsArray[row].distance)"
        return cell
    }
    //Función a llamar para enviar notificaciones
    
    func EnviarNotificacion(code: Int,nombre:String,id: Int64) {
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
        switch code{
        case 0:
            localNotification.alertBody = "El beacon \(nombre) se alejó"
            break
        case 1:
            localNotification.alertBody = "El beacon \(nombre) vuelve a estar en el rango"
            break
        default:
            break
        }
        do{
            let notificaciones = try NotificationsDataHelper.findAll()
            localNotification.userInfo = ["uid" : Int(id) ]
            localNotification.applicationIconBadgeNumber = (notificaciones?.count)!
        }catch _ {
            print("error al mostrar notificaciones")
        }
        
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    func guardarNotificacion(id: Int64) -> Int64 {
        let ntf = Notification()
        ntf.firedate = NSDate(timeIntervalSinceNow: 1)
        ntf.beaconId = id
     
        
        do{
            let id = try NotificationsDataHelper.insert(ntf)
           // notification.userInfo = ["uid" : Int(id) ]
            return id
            print("Notificacion insertada")
        }catch _{
            print("Error al crear el ingrediente")
            return 0
        }
        
    }
    func rellenarSet (){
        do {
            beaconsArray = try BeaconDataHelper.findAllbyGroup(group)!
           
            
        }catch{
            
        }
    }


}*/
