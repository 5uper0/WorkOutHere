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
import CoreLocation

class ServerManager: NSObject {
    
    static let shared = ServerManager()

    let usersKey = "users"
    let adsKey = "ads"
    
    // MAKR: - User sign in
    
    func signInUserWithFacebookCredential(_ viewController: UIViewController, completionHandler: @escaping (Bool) -> ()) {
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            
            if let error = error {
                Utilities.shared.showAlert(withTitle: "Alert", andMessage: error.localizedDescription, in: viewController)
                
            } else {
                
                completionHandler(true)
            }
        }

    }

    // MARK: - GET requests
    
    func getUserInfo(completionHandler: @escaping (User) -> ()) {
        // GET user info from Facebook profile
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
    
    func getAdLocationWith(completionHandler: @escaping ([Location]) -> ()) {
        
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()!.currentUser!.uid

        ref.child(adsKey).child(userID).observeSingleEvent(of: .value, with: { snapshot in
            
            if snapshot.exists() {
                
                var locations: [Location] = []
                
                for child in snapshot.children.allObjects {
                    
                    let childSnapshot = child as! FIRDataSnapshot
                    let snapshotDict = childSnapshot.value as! NSDictionary
                    
                    let latitude = "\(snapshotDict["latitude"] as! NSNumber)"
                    let longitude = "\(snapshotDict["longitude"] as! NSNumber)"
                                        
                    locations.append(Location.init(withLatitude: latitude, andLongitude: longitude))
                }
                
                completionHandler(locations)
            }
        })
    }
    
    // MARK: - POST requests

    func postUserInfo(withUser user: User) {
        // POST user info to Firebase database
        
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()!.currentUser!.uid
        
        ref.child(usersKey).child(userID).setValue(["name" : user.name,
                                                    "birthday" : user.birthday,
                                                    "coutry" : user.location.country ,
                                                    "city" : user.location.city,
                                                    "email" : user.email,
                                                    "gender" : user.gender.string])
        
    }
    
    func postLocationMarker(withAd coordinate: CLLocationCoordinate2D) {
        // POST location marker to Firebase database
        
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()!.currentUser!.uid
        let postID = ref.child(adsKey).childByAutoId().key
        
        ref.child(adsKey).child(userID).child(postID).setValue(["latitude" : coordinate.latitude,
                                                  "longitude" : coordinate.longitude])

    }
}
