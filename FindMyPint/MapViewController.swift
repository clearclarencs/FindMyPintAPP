//
//  ViewController.swift
//  UserLocation
//
//  Created by Phil Jimmieson on 20/11/2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let pubs = [
        ("The Sphinx", 53.40501748448972, -2.966496069757191),
        ("The Augustus John", 53.405754859909464, -2.964630449373654),
        ("The Font", 53.40303429268724, -2.9685573),
        ("The Bullring Bar", 53.40880117625418, -2.9708216908620537),
        ("Hope & Anchor", 53.402379633989376, -2.9709933522383745),
        ("The Cambridge Public House", 53.4024349071364, -2.9667896)
    ]
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var firstRun = true
    var startTrackingTheUser = false
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationOfUser = locations[0] //this method returns an array of locations
        
        let latitude = locationOfUser.coordinate.latitude
        let longitude = locationOfUser.coordinate.longitude
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        if firstRun {
            firstRun = false
            let latDelta: CLLocationDegrees = 0.01
            let lonDelta: CLLocationDegrees = 0.01
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            
            //a region defines a centre and a size of area covered.
            let region = MKCoordinateRegion(center: location, span: span)
            
            //make the map show that region we just defined.
            self.mapView.setRegion(region, animated: true)
            
            _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(startUserTracking), userInfo: nil, repeats: false)
        }
        
        if startTrackingTheUser == true {
            mapView.setCenter(location, animated: true)
        }
        
        // Plot local pubs
        for (pub, lat, long) in pubs{
            let newCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinate
            annotation.title = pub
            self.mapView.addAnnotation(annotation)
        }
    }
    
    //this method sets the startTrackingTheUser boolean class property to true. Once it's true, subsequent calls
    //to didUpdateLocations will cause the map to center on the user's location.
    @objc func startUserTracking() {
        startTrackingTheUser = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }

    
    
}

