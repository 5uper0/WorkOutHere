//
//  Ad.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/21/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit

class Ad: ServerObject {

    enum TypeOf {
        case unknown
        case property
        case job
        case expert
        case customer
    }
    
    enum currency {
        case uah
        case usd
        case eur
    }
    
    var type: TypeOf = .unknown
    
    var city = ""
    var country = ""
    var price = ""
    var photos: [String] = []
    var links: [String] = []
    var user: User?
    
}
