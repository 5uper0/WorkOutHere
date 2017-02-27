//
//  LoginViewController.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/17/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var loginFacebookButton: FBSDKLoginButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLoginButton()
        
        if FIRAuth.auth()?.currentUser != nil && FBSDKAccessToken.current() != nil {
            self.performSegue(withIdentifier: "ProfileViewController", sender: self)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: - Actions
    
    
    
    // MARK: - Private Methods
    
    func initializeLoginButton() {
        loginFacebookButton.delegate = self
        loginFacebookButton.readPermissions = [
            "public_profile",
            "user_birthday",
            "user_location",
            "email"]

    }
    
    func showAlert(withMessage string: String) {
        Utilities.shared.showAlert(withTitle: "Alert", andMessage: string, in: self)

    }
    
    // MARK: - FBSDKLoginButtonDelegate
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if (error != nil) {
            showAlert(withMessage: error.localizedDescription)
            
        } else if (result.isCancelled) {
            showAlert(withMessage: "Login cancelled")
            
        } else {
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                
                if let error = error {
                    self.showAlert(withMessage: error.localizedDescription)
                    
                } else {
                    self.performSegue(withIdentifier: "ProfileViewController", sender: self)
                    
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
