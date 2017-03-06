//
//  Ad.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/21/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit
import CoreLocation

class Ad: ServerObject {

    enum TypeOf {
        case unknown
        case property
        case job
        case expert
        case customer
    }
    
    enum Currency {
        case usd
        case eur
        case uah
    }
    
    var type: TypeOf = .unknown
    var price: (value: Float, currency: Ad.Currency) = (0.0, .usd)
    var location = Location()
    var photos: [String] = []
    var links: [String] = []
    var user = User()
    
    override init() {
        super.init()
    }
    
    init(withLocation location: CLLocationCoordinate2D) {
        super.init()
        
        
    }
    
}
