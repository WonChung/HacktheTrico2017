//
//  Map1ViewController.swift
//  HacktheTrico
//
//  Created by Joshua Freier on 3/25/17.
//  Copyright © 2017 Cassandra Stone. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Map1ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager!

  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MKUserTrackingMode(rawValue: 2)!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
