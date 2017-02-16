//
//  LocationViewController.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/6/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let mapMarker = GMSMarker()
    var mapCircle = GMSCircle()

    var zoom: Float = 12.0
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var showUserLocation: UIButton!
    
    enum ActionSheetType {
        case addNew
        case search
    }
    
    // MARK: - System functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLocationManager()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.mapView.bringSubview(toFront: showUserLocation)
    }
    
    // MARK: - Initializers
    
    func initLocationManager() {
                
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            initGoogleMaps()
            
        } else {
            
            alertShow()
        }
    }
    
    func initGoogleMaps() {
        
        let coordinate = locationManager.location!.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude,
                                              longitude: coordinate.longitude,
                                              zoom: zoom)
        
        mapView.camera = camera
        mapView.isMyLocationEnabled = true

    }
    
    // MARK: - Actions
    
    @IBAction func actionAddNew(_ sender: UIBarButtonItem) {
        actionSheetShowWith(actionType: .addNew)
    }
    
    @IBAction func actionSearch(_ sender: UIBarButtonItem) {
        actionSheetShowWith(actionType: .search)
    }
    
    @IBAction func actionAddMarker(_ sender: UIBarButtonItem) {
        
        //mapView.clear()
        
        let coordinate = mapView.camera.target
        addMarkerAt(coordinate: coordinate)
    }
    
    @IBAction func actionShowLocation(_ sender: UIButton) {
        
        let coordinate = locationManager.location!.coordinate
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
        mapView.animate(to: camera)
    }
    
    
    // MARK: - Private methods
    
    func actionSheetShowWith(actionType: ActionSheetType) {
        // Create the AlertController and add its actions like button in ActionSheet
        
        let optionName = actionType == .search ? "search" : "add new"
        
        let title = "Please select an option to " + optionName
        
        let actionSheetController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        let propertyButton = UIAlertAction(title: "Property", style: .default) { action -> Void in
            print("Property")
        }
        actionSheetController.addAction(propertyButton)
        
        let jobButton = UIAlertAction(title: "Job", style: .default) { action -> Void in
            print("Job")
        }
        actionSheetController.addAction(jobButton)
        
        let expertButton = UIAlertAction(title: "Expert", style: .default) { action -> Void in
            print("Expert")
        }
        actionSheetController.addAction(expertButton)
        
        let customerButton = UIAlertAction(title: "Customer", style: .default) { action -> Void in
            print("Customer")
        }
        actionSheetController.addAction(customerButton)

        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelButton)
        
        self.present(actionSheetController, animated: true, completion: nil)
    
    }
    
    func alertShow() {
        
        let alert = UIAlertController(title: "Alert", message: "Unable to connect your location", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addMarkerAt(coordinate: CLLocationCoordinate2D) {
        
        let radius: CLLocationDistance = 5000

        mapMarker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        mapMarker.title = "Here You Are"
        mapMarker.snippet = "Hello!"
        mapMarker.icon = UIImage(named: "MapMarker")
        mapMarker.map = mapView

        addCircleAt(coordinate: coordinate, radius: radius)

    }
    
    func addCircleAt(coordinate: CLLocationCoordinate2D,
                     radius: CLLocationDistance) {
        
        mapCircle.fillColor = Utilities.shared.colorTransparent()
        mapCircle = GMSCircle(position: coordinate, radius: radius)
        mapCircle.fillColor = Utilities.shared.colorWith(R: 4.0, G: 149.0, B: 255.0, alpha: 0.1)
        mapCircle.strokeColor = Utilities.shared.colorTransparent()
        mapCircle.strokeWidth = 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.mapCircle.map = self.mapView

        })

    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

