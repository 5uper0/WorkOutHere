//
//  User.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/21/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit

class User: ServerObject {
    
    public enum Gender: Int {
        case male
        case female
        case unknown
    }
    
    var userID = ""
    var name = ""
    var email = ""
    var gender: (string: String, enum: Gender) = ("", Gender.unknown)
    var birthday = ""
    var location = Location()
    var city = ""
    var website = ""
    var phone = ""
    var ads: [Ad] = []
    
    override init() {
        super.init()
    }
    
    override init(withResult dictionary: NSDictionary) {
        super.init()
        
        self.userID = dictionary["id"] as! String
        self.name = dictionary["first_name"] as! String
        self.email = dictionary["email"] as! String
        self.gender.string = dictionary["gender"] as! String
        
        if self.gender.string == "male" {
            self.gender.enum = .male
            
        } else if self.gender.string == "female" {
            self.gender.enum = .female
        }
        
        let location = dictionary["location"] as! NSDictionary
        let locationName = location["name"] as! String
        let index1 = locationName.range(of: " ", options: .backwards)?.lowerBound
        var country = locationName.substring(from: index1!)
        self.location.country = country.substring(from: country.characters.index(country.startIndex, offsetBy: 1))
        
        let index2 = locationName.range(of: ",", options: .backwards)?.lowerBound
        self.location.city = locationName.substring(to: index2!)

        
        self.birthday = dictionary["birthday"] as! String
                
        ServerManager.shared.postUserInfo(withUser: self)
    }

}
