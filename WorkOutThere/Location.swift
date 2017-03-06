//
//  Location.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/28/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit
import CoreLocation

class Location: ServerObject {
    
    var latitude = ""
    var longitude = ""
    var city = ""
    var country = ""
    var title = ""
    var snippet = ""
    
    override init() {
        super.init()
    }
    
    init(withLatitude latitude: String, andLongitude longitude: String) {
        super.init()
        
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        
        let latitude = (self.latitude as NSString).doubleValue
        let longitude = (self.longitude as NSString).doubleValue
        
        return CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
    }
    
}
