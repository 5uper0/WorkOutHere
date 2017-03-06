//
//  Constants.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/17/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    static let shared = Constants()
    
    let dataURL = "https://workout-c17fa.firebaseio.com"
    
    // MARK: - Map colors
    
    let mapMarkerColor = UIColor.black
    let mapCircleFillColor = Utilities.shared.colorWith(R: 4.0, G: 149.0, B: 255.0, alpha: 0.1)

}
