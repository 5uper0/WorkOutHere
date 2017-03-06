//
//  LocationViewController.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/6/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit
import GoogleMaps
import YNDropDownMenu

class LocationViewController: UIViewController, CLLocationManagerDelegate {
 
    enum ActionSheetType {
        case addNew
        case search
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var dropDownMenuView: YNDropDownMenu!
    
    let locationManager = CLLocationManager()
    let mapMarker = GMSMarker()
    
    var mapCircle = GMSCircle()
    var zoom: Float = 12.0
    
    // MARK: - System functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLocationManager()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.accessibilityElementsHidden = false
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        
        initDropDownMenuView()

    }
    
    func initDropDownMenuView() {
        
        let dropDownViews = Bundle.main.loadNibNamed("DropDownMenu", owner: nil, options: nil) as? [UIView]
        
        
        let view = YNDropDownMenu(frame:dropDownMenuView.bounds, dropDownViews: dropDownViews!, dropDownViewTitles: ["Action settings"])
        mapView.addSubview(view)

        // Inherit YNDropDownView if you want to hideMenu in your dropDownViews
        view.setImageWhen(normal: UIImage(named: "arrow_enabled"), selected: UIImage(named: "arrow_enabled"), disabled: UIImage(named: "arrow_disabled"))
        view.setLabelColorWhen(normal: UIColor.darkGray, selected: UIColor.darkGray, disabled: UIColor.white)
        view.setLabelFontWhen(normal: UIFont.systemFont(ofSize: 11), selected: UIFont.boldSystemFont(ofSize: 12), disabled: UIFont.systemFont(ofSize: 10))
        
        view.backgroundBlurEnabled = true
                
        view.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.2)
        
        // Add custom blurEffectView
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black
        view.blurEffectView = backgroundView
        view.blurEffectViewAlpha = 0.7
        
        // Open and Hide Menu
        view.alwaysSelected(at: 0)
        //            view.disabledMenuAt(index: 2)
        //view.showAndHideMenuAt(index: 3)
        self.view.bringSubview(toFront: view)
        dropDownMenuView = view
    }
    
    // MARK: - Actions
    
    @IBAction func actionAddNew(_ sender: UIBarButtonItem) {
//        actionSheetShowWith(actionType: .addNew)
        
    }
    
    @IBAction func actionSearch(_ sender: UIBarButtonItem) {
//        actionSheetShowWith(actionType: .search)
        ServerManager.shared.getAdLocationWith { (locations) in
            
            self.mapView.clear()
            
            var bounds = GMSCoordinateBounds()
            
            for location in locations {
                
                let coordinate = location.getCLLocationCoordinate2D()
                
                self.initMarker(withMarker: GMSMarker(), coordinate: coordinate, title: location.title, snippet: location.snippet, needsCircle: false)
                bounds = bounds.includingCoordinate(coordinate)
            }
            
            let update = GMSCameraUpdate.fit(bounds, withPadding: 15.0)
            self.mapView.animate(with: update)
            
        }
    }
    
    @IBAction func actionAddMarker(_ sender: UIBarButtonItem) {
        
        //mapView.clear()
        
        let coordinate = mapView.camera.target
        initMarker(withMarker: mapMarker, coordinate: coordinate, title: "Hello!", snippet: "Here you are", needsCircle: true)
        
        ServerManager.shared.postLocationMarker(withAd: coordinate)
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
        Utilities.shared.showAlert(withTitle: "Alert", andMessage: "Unable to connect your location", in: self)
    }
    
    func initMarker(withMarker marker: GMSMarker, coordinate: CLLocationCoordinate2D, title: String, snippet: String, needsCircle: Bool) {
        
        let radius: CLLocationDistance = 5000
        
        marker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        marker.title = title
        marker.snippet = snippet
        marker.appearAnimation = .pop
        marker.icon = GMSMarker.markerImage(with: Constants.shared.mapMarkerColor)
        marker.map = mapView
        
        if needsCircle {
            addCircleAt(coordinate: coordinate, radius: radius)
        }
    }
    
    func addCircleAt(coordinate: CLLocationCoordinate2D,
                     radius: CLLocationDistance) {
        
        mapCircle.fillColor = Utilities.shared.colorTransparent()
        mapCircle = GMSCircle(position: coordinate, radius: radius)
        mapCircle.fillColor = Constants.shared.mapCircleFillColor
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

