//
//  CompassManager.swift
//  CompassGuesser
//
//  Created by Alisha Qureshi on 6/17/25.
//

import Foundation
import CoreLocation

class CompassManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var heading: Double = 0.0

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.main.async {
            self.heading = newHeading.magneticHeading
        }
    }
}
