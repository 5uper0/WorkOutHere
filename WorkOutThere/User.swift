//
//  User.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/21/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit

class User: ServerObject {
    
    enum Gender {
        case unknown
        case male
        case female
    }
    
    var name = ""
    var email = ""
    var gender: Gender = .unknown
    var dateOfBirth = ""
    var country = ""
    var city = ""
    var website = ""
    var phone = ""
    var ads: [Ad] = []

}
