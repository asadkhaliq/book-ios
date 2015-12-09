//
//  SettingsChooseLocationViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/3/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SettingsChooseLocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    
    var cityName : String?
    
    private var userDefaults = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    @IBOutlet weak var detectedCityLabel: UILabel!
    @IBOutlet weak var enteredCityField: UITextField!
    
    
    
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
        enteredCityField.delegate = self
    }


    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location!)
            {
                (placemarks, error) -> Void in
                let placeArray = placemarks as [CLPlacemark]!
                var placeMark: CLPlacemark!
                placeMark = placeArray?[0]
                
                if let city = placeMark.addressDictionary?["City"] as? NSString
                {
                    self.cityName = city as String
                    self.detectedCityLabel.text = "Current Detected City:" + (city as String)
                }
        }
    }

    
    @IBAction func setCityFinal(sender: AnyObject) {
        if cityName != nil {
            userDefaults.setObject(cityName, forKey: "cityname")
            self.navigationController?.popViewControllerAnimated(true)

        }
        else {
            let alertController = UIAlertController(title: nil, message: "No Location Set!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)

        }

    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }
    
    @IBAction func setCurrentCity(sender: UIButton) {
    }
    
    @IBAction func setManuallySearchedCity(sender: UIButton) {
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }

        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = enteredCityField.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }

            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = self.enteredCityField.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            
            self.cityName = self.enteredCityField.text
        }
    }
    

}
