//
//  KidBeacon
//  Creado por Mikel Balduciel Diaz, Eduardo González de la Huebra Sánchez y David Jiménez Guinaldo en 2016
//  para el Club Universitario de Innovación de la Universidad Pontificia de Salamanca.
//  Copyright © 2016. Todos los derecho reservados.
//

import UIKit
import Foundation
import MapKit

class MapBeaconsRastreatorViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate  {
    @IBOutlet weak var mapView: MKMapView!
    var locationManager : CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self

        
    }
    let regionRadius: CLLocationDistance = 50
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addRadiusCircle(location: CLLocation){
        self.mapView.delegate = self
        let circle = MKCircle(centerCoordinate: location.coordinate, radius: 50 as CLLocationDistance)
        self.mapView.addOverlay(circle)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.redColor()
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return MKCircleRenderer()
        }
    }
    //MARK - Location Manager
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if (NSProcessInfo.processInfo().environment["SIMULATOR_DEVICE_NAME"] != nil){
            print("Usando simulador")
            
        }
        else{
            
            switch status{
                
            case .AuthorizedAlways:
        
                let location = CLLocation(latitude: manager.location!.coordinate.latitude as CLLocationDegrees, longitude: manager.location!.coordinate.longitude as CLLocationDegrees)
                centerMapOnLocation(location)
                addRadiusCircle(location)
                manager.startUpdatingLocation()
                
                break;
            default:
                print("Other location permission: \(status)")
                break
            }
            
            
        }
    }

}
