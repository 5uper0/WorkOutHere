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
    var gender = ""
    var genderEnum: Gender = .unknown
    var birthday = ""
    var location = ""
    var city = ""
    var website = ""
    var phone = ""
    var ads: [Ad] = []
    
    override init() {
        super.init()
    }
    
    init(withResult dictionary: NSDictionary) {
        super.init()
        
        self.userID = dictionary["id"] as! String
        self.name = dictionary["first_name"] as! String
        self.email = dictionary["email"] as! String
        self.gender = dictionary["gender"] as! String
        
        if self.gender == "male" {
            self.genderEnum = .male
            
        } else if self.gender == "female" {
            self.genderEnum = .female
        }
        
        self.birthday = dictionary["birthday"] as! String
        
        print("\nUSER: \(self.userID)")
        
        ServerManager.shared.postUserInfoToFirebaseStorage(user: self)
    }

}
