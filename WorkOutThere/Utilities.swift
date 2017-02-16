//
//  Utilities.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/15/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit

class Utilities: NSObject {

    static let shared = Utilities()
    
    func colorWith(R: CGFloat, G: CGFloat, B: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: alpha)
    }
    
    func colorTransparent() -> UIColor {
        return colorWith(R: 1.0, G: 1.0, B: 1.0, alpha: 0.0)
    }

}
