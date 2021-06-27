//
//  LocationHandler.swift
//  ibi_demo
//
//  Created by WY on 2021/6/24.
//

import Foundation
import SwiftUI
import CoreLocation

class LocationHandler: NSObject, ObservableObject{
   
    //static var shared = LocationHandler()
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLHeadingFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        //locationManager.allowsBackgroundLocationUpdates = true
        //locationManager.pausesLocationUpdatesAutomatically = false
    
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus

        switch status {

        case .notDetermined:

            print("DEBUG: LH.enableLocationSevices: not determined")
            manager.requestWhenInUseAuthorization()

        case .restricted, .denied:

            print("DEBUG: LH.enableLocationSevices: restricted or denied")

        case .authorizedAlways:

            print("DEBUG: authorized always")

        case .authorizedWhenInUse:

            print("DEBUG: authorized when in use")
            manager.requestAlwaysAuthorization()

        @unknown default:
            break
        }
    }
    

}

extension LocationHandler: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{return}
        //locationManager.stopUpdatingLocation()
        
        DispatchQueue.main.async {
            self.location = location
        }
    }
}
