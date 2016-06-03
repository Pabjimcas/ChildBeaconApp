//
//  KidBeacon
//  Creado por Mikel Balduciel Diaz, Eduardo González de la Huebra Sánchez y David Jiménez Guinaldo en 2016
//  para el Club Universitario de Innovación de la Universidad Pontificia de Salamanca.
//  Copyright © 2016. Todos los derecho reservados.
//

import UIKit

class BeaconTableViewCell: UITableViewCell {

    @IBOutlet weak var nameBeaconLabel: UILabel!
    @IBOutlet weak var uuidBeaconLabel: UILabel!
    @IBOutlet weak var editBt: UIButton!
    @IBOutlet weak var deleteBt: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

}
