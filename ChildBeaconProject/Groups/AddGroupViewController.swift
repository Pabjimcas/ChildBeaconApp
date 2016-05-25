//
//  AddGroupViewController.swift
//  ChildBeaconProject
//
//  Created by mikel balduciel diaz on 17/3/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController {
  
  @IBOutlet weak var nameTf: UITextField!
  @IBOutlet weak var uuidTf: UITextField!
  var delegate : MainViewController?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddGroupViewController.dismissKeyboard))
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
  

  
  @IBAction func cancelAction(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: {})
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
}
