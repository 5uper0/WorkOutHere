//
//  ProfileViewController.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/17/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class ProfileViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var loginFacebookButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        loginFacebookButton.readPermissions = ["public_profile", "email"]

    }
    
    @IBAction func actionRegister(_ sender: UIButton) {
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
        
            print("user = \(user), \nerror = \(error)")
        })
    
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
