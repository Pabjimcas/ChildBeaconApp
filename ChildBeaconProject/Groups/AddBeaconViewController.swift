//
//  KidBeacon
//  Creado por Mikel Balduciel Diaz, Eduardo González de la Huebra Sánchez y David Jiménez Guinaldo en 2016
//  para el Club Universitario de Innovación de la Universidad Pontificia de Salamanca.
//  Copyright © 2016. Todos los derecho reservados.
//

import UIKit

class AddBeaconViewController: UIViewController {
  
  @IBOutlet weak var nameTf: UITextField!
  @IBOutlet weak var minorTf: UITextField!
  @IBOutlet weak var majorTf: UITextField!
  var groupId : Int64!
  var groupUUID : String!
  var delegate : GroupViewController?
  var beacon : Beacon?
  override func viewDidLoad() {
    super.viewDidLoad()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    view.addGestureRecognizer(tap)
    if beacon != nil  {
      updateBeacon(beacon!)
    }
  }
  func updateBeacon(beacon: Beacon){
    nameTf.text = beacon.name
    minorTf.text = beacon.minor
    majorTf.text = beacon.major
  }
  

  @IBAction func addAction(sender: AnyObject) {
    if !nameTf.text!.isEmpty  && !minorTf.text!.isEmpty && !majorTf.text!.isEmpty{
      do {
        if beacon != nil {
          
          try Beacon.updateBeacon((beacon?.beaconId)!,name: nameTf.text!, minor: minorTf.text!, major: majorTf.text!)
          self.dismissViewControllerAnimated(true, completion: {})
          
          print("actualizacion correcta: \(nameTf.text!)")
        }else {
          try Beacon.addBeacon(nameTf.text!, minor: minorTf.text!, major: majorTf.text!,group:groupId,groupUUID: groupUUID)
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
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.view.endEditing(true)
    
    return true
  }
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  
}
