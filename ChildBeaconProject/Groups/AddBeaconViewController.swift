//
//  AddBeaconViewController.swift
//  ChildBeaconProject
//
//  Created by mikel balduciel diaz on 17/3/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

import UIKit

class AddBeaconViewController: UIViewController {

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var minorTf: UITextField!
    @IBOutlet weak var majorTf: UITextField!
    var groupId : Int64!
    var delegate : GroupViewController?
    var beacon : Beacon?
    override func viewDidLoad() {
        super.viewDidLoad()
        if beacon != nil  {
            updateBeacon(beacon!)
        }
        // Do any additional setup after loading the view.
    }
    func updateBeacon(beacon: Beacon){
        nameTf.text = beacon.name
        minorTf.text = beacon.minor
        majorTf.text = beacon.major
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addAction(sender: AnyObject) {
        if !nameTf.text!.isEmpty  && !minorTf.text!.isEmpty && !majorTf.text!.isEmpty{
            do {
                if beacon != nil {
                    
                    try Beacon.updateBeacon((beacon?.beaconId)!,name: nameTf.text!, minor: minorTf.text!, major: majorTf.text!)
                    self.dismissViewControllerAnimated(true, completion: {})
                    
                    print("actualizacion correcta: \(nameTf.text!)")
                }else {
                    try Beacon.addBeacon(nameTf.text!, minor: minorTf.text!, major: majorTf.text!,group:groupId)
                    self.dismissViewControllerAnimated(true, completion: {})
                    
                    print("insercion correcta: \(nameTf.text!)")
                }
                
            }catch {
                let ac = UIAlertController(title: "Nombre repetido", message: "Es necesario que el nombre no exista ya en el dispositivo", preferredStyle: .Alert)
                ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                presentViewController(ac, animated: true, completion: nil)
                print ("Error al insertar grupo")
            }
        }
        
    }
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    

   

}
