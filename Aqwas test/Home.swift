//
//  ViewController.swift
//  Aqwas test
//
//  Created by 2p on 5/16/20.
//

import UIKit
import GoogleMaps
import GooglePlaces
class Home: UIViewController {
    let locationManager = CLLocationManager()
    var myCurrentLocation : CLLocationCoordinate2D!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
    @IBAction func suggestionBtn(_ sender: Any) {
        performSegue(withIdentifier: "mapseg", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapseg" {
            if let viewController = segue.destination as? MapViewController {
                viewController.myCurrentLocation = self.myCurrentLocation
                
            }
        }
    }
}

extension Home: CLLocationManagerDelegate {
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location)
            self.myCurrentLocation = location.coordinate
            locationManager.stopUpdatingLocation()
        }
    }
}
