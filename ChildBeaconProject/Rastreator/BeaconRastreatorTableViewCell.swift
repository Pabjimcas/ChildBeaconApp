//
//  KidBeacon
//  Creado por Mikel Balduciel Diaz, Eduardo González de la Huebra Sánchez y David Jiménez Guinaldo en 2016
//  para el Club Universitario de Innovación de la Universidad Pontificia de Salamanca.
//  Copyright © 2016. Todos los derecho reservados.
//

import UIKit
import CoreLocation

class BeaconRastreatorTableViewCell: UITableViewCell {
    @IBOutlet weak var valueTextView: UITextView!
    
    var item: Beacon? {
        willSet {
            if let thisItem = item {
                thisItem.removeObserver(self, forKeyPath: "lastSeenBeacon")
            }
        }
        didSet {
            item?.addObserver(self, forKeyPath: "lastSeenBeacon", options: .New, context: nil)
            textLabel!.text = item?.name
        }
        
    }
    deinit {
        item?.removeObserver(self, forKeyPath: "lastSeenBeacon")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func nameForProximity(proximity: CLProximity) -> String {
        switch proximity {
        case .Unknown:
            return "Desconocido"
        case .Immediate:
            return "Inmediato"
        case .Near:
            return "Cerca"
        case .Far:
            return "Lejos"
        }
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let anItem = object as? Beacon {
            if anItem == item && keyPath == "lastSeenBeacon" {
                let proximity = nameForProximity(anItem.lastSeenBeacon!.proximity)
                let accuracy = NSString(format: "%.2f", anItem.lastSeenBeacon!.accuracy)
                detailTextLabel!.text = "Location: \(proximity) (approx. \(accuracy)m)"
            }
        }
    }
    
}