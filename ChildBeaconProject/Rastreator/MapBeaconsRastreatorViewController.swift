//
//  MapBeaconsRastreatorViewController.swift
//  ChildBeaconProject
//
//  Created by mikel balduciel diaz on 17/3/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
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
        // var location = CLLocation(latitude: 40.95 as CLLocationDegrees, longitude: -5.68 as CLLocationDegrees)
        
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
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.2)
            circle.lineWidth = 1
            return circle
        } else {
            return MKOverlayRenderer()
        }
    }
    //MARK - Location Manager
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if (NSProcessInfo.processInfo().environment["SIMULATOR_DEVICE_NAME"] != nil){
            print("Usando simulador")
            
        }
        else{
            
            switch status{
                
            case .AuthorizedWhenInUse:
                
                let center = CLLocationCoordinate2D(latitude: manager.location!.coordinate.latitude, longitude: manager.location!.coordinate.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                let location = CLLocation(latitude: manager.location!.coordinate.latitude as CLLocationDegrees, longitude: manager.location!.coordinate.longitude as CLLocationDegrees)
                mapView.setRegion(region, animated: true)
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
