//
//  KidBeacon
//  Creado por Mikel Balduciel Diaz, Eduardo González de la Huebra Sánchez y David Jiménez Guinaldo en 2016
//  para el Club Universitario de Innovación de la Universidad Pontificia de Salamanca.
//  Copyright © 2016. Todos los derecho reservados.
//

import UIKit

class AddGroupViewController: UIViewController {
  
  @IBOutlet weak var nameTf: UITextField!
  @IBOutlet weak var uuidTf: UITextField!
  var delegate : MainViewController?
  override func viewDidLoad() {
    super.viewDidLoad()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  @IBAction func saveAction(sender: AnyObject) {
    do {
      if let text = nameTf.text where !text.isEmpty{
        try BeaconGroup.addBeaconGroup(nameTf.text!,uuid: uuidTf.text!)
        self.dismissViewControllerAnimated(true, completion: {})
        
        print("insercion correcta: \(nameTf.text!)")
      }
      
    } catch{
      let ac = UIAlertController(title: "Nombre repetido", message: "Es necesario que el nombre no exista ya en el dispositivo", preferredStyle: .Alert)
      ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
      presentViewController(ac, animated: true, completion: nil)
      print ("Error al insertar grupo")
    }
  }
  @IBAction func closeKeyboardAction(sender: AnyObject) {
    resignFirstResponder()
  }
  
  @IBAction func cancelAction(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: {})
  }
  func dismissKeyboard() {
    view.endEditing(true)
  }
}
