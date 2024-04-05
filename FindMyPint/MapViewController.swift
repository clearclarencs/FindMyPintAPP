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
    
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var firstRun = true
    var startTrackingTheUser = false // If map should center on user (for navigation)
    
    @IBAction func planRoute(_ sender: Any) {
        if (routeButton.isSelected){ // plot route
            var selectedPubs: [(String, Double, Double)] = []
            for annotation in mapView.annotations{
                if mapView.view(for: annotation)!.isHighlighted{
                    selectedPubs.append((annotation.title!!, annotation.coordinate.latitude, annotation.coordinate.longitude))
                }
            }
            
            if !selectedPubs.isEmpty{  // Plot route
                plotRoute(selectedPubs)
            }
        } else { // Clear map of any selections/routes
            
        }
        
        routeButton.isSelected = !routeButton.isSelected
        if routeButton.isSelected{
            routeButton.layer.opacity = 0.7
        } else {
            routeButton.layer.opacity = 1.0
        }
    }
    
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    func plotRoute(_ pubs: [(String, Double, Double)]){
        for i in 1...pubs.count-1{
            let sourceCoordinate = CLLocationCoordinate2D(latitude: pubs[i-1].1, longitude: pubs[i-1].2)
            let destinationCoordinate = CLLocationCoordinate2D(latitude: pubs[i].1, longitude: pubs[i].2)
            
            let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
            let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
            
            let sourceItem = MKMapItem(placemark: sourcePlacemark)
            let destinationItem = MKMapItem(placemark: destinationPlacemark)
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = sourceItem
            directionRequest.destination = destinationItem
            directionRequest.transportType = .walking // Change this based on your needs
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate { (response, error) in
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    return
                }
                
                let route = response.routes[0]
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            }
        }
    }
                                                               
   func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
       if overlay is MKPolyline {
           let renderer = MKPolylineRenderer(overlay: overlay)
           renderer.strokeColor = UIColor(red: 60.0/255.0, green: 133.0/255.0, blue: 168.0/255.0, alpha: 1.0)
           renderer.lineWidth = 4.0
           return renderer
       }
       return MKOverlayRenderer(overlay: overlay)
   }
    
    
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
            
            // _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(startUserTracking), userInfo: nil, repeats: false)
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // guard let annotation = view.annotation else { return }
        // let pub = (annotation.title, annotation.coordinate.latitude, annotation.coordinate.longitude)
        if (routeButton.isSelected){  // (de)Select pub for route
            view.isHighlighted = !view.isHighlighted
            if view.isHighlighted{  // select pub
                view.layer.opacity = 0.6
            } else {  // deselect pub
                view.layer.opacity = 1
            }
        } else {  // View details
            performSegue(withIdentifier: "loactionDetailSegue", sender: self)
        }
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

