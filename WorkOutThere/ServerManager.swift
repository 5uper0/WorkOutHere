//
//  ServerManager.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/14/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase

class ServerManager: NSObject {
    
    static let shared = ServerManager()

    func getUserInfo(completionHandler: @escaping (User) -> ()) {
        
        let fields = "id, first_name, last_name, email, picture.type(large), birthday, currency, gender, location"
        
        let graphRequest: FBSDKGraphRequest =
            FBSDKGraphRequest(graphPath: "me",
                              parameters: ["fields" : fields])
        
        graphRequest.start { (connection, result, error) in
            
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
                
            } else {
                completionHandler(User(withResult: result as! NSDictionary))
            }
        }

    }
    
    func postUserInfoToFirebaseStorage(user: User) {
        
        let ref = FIRDatabase.database().reference()
        
        let userID = FIRAuth.auth()!.currentUser!.uid
        
        ref.child("users").child(userID).setValue(["name" : user.name as String])
        ref.child("users").child(userID).setValue(["birthday" : user.birthday as String])
        ref.child("users").child(userID).setValue(["location" : user.location as String])
        ref.child("users").child(userID).setValue(["email" : user.email as String])
        ref.child("users").child(userID).setValue(["gender" : user.gender as String])
        
    }
}
