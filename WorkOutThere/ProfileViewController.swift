//
//  ProfileViewController.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/22/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let nameAndFieldTableCellIdentifier = "NameAndFieldTableCell"
    let nameAndSegControlTableCellIdentifier = "NameAndSegControlTableCell"
    let buttonTableCellIdentifier = "ButtonTableCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var user = User()
    
    open var userAdsCount: Int = 0

    enum RowName: Int {
        case name
        case email
        case gender
        case birthday
        case country
        case city
        case phone
        case website
        case count // leave it last for count number of properties of this enum
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUserInfo()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func actionLogout(_ sender: UIBarButtonItem) {
        logout()
    }
    
    // MARK: - Private Methods
    
    func getUserInfo() {
        ServerManager.shared.getUserInfo { (user) in
                        
            self.user = user
            
            self.tableView.reloadData()
        }
    }
    
    func logout() {
        
        do {
            try FIRAuth.auth()?.signOut()
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            
        }
        
        FBSDKLoginManager().logOut()
        
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RowName.count.rawValue + userAdsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        switch indexPath.row {
            
        case RowName.name.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: nameAndFieldTableCellIdentifier) as! NameAndFieldTableCell
            cell.configureCell(with: "Name", placeholder: "Bill Clinton", andText: user.name)
            return cell

        case RowName.email.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: nameAndFieldTableCellIdentifier) as! NameAndFieldTableCell
            cell.configureCell(with: "E-mail", placeholder: "name@mail.com", andText: user.email)
            return cell
            
        case RowName.gender.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: nameAndSegControlTableCellIdentifier) as! NameAndSegControlTableCell
            cell.configureCell(with: "Gender", firstTitle: "Male", andSecondTitle: "Female")
            cell.setSegment(with: user.gender.enum)
            
            return cell
            
        case RowName.birthday.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: nameAndFieldTableCellIdentifier) as! NameAndFieldTableCell
            cell.configureCell(with: "Birthday", placeholder: "33", andText: user.birthday)
            return cell
            
        case RowName.country.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: nameAndFieldTableCellIdentifier) as! NameAndFieldTableCell
            cell.configureCell(with: "Country", placeholder: "Choose one", andText: user.location.country)
            return cell
            
        case RowName.city.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: nameAndFieldTableCellIdentifier) as! NameAndFieldTableCell
            cell.configureCell(with: "City", placeholder: "Nice place to live", andText: user.location.city)
            return cell
            
        case RowName.phone.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: nameAndFieldTableCellIdentifier) as! NameAndFieldTableCell
            cell.configureCell(with: "Phone", placeholder: "+1 234-56-78", andText: "")
            return cell
            
        case RowName.website.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: nameAndFieldTableCellIdentifier) as! NameAndFieldTableCell
            cell.configureCell(with: "Website", placeholder: "yoursite.com", andText: "")
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: nameAndFieldTableCellIdentifier) as! NameAndFieldTableCell
            cell.configureCell(with: "Name", placeholder: "Bill Clinton", andText: "")
            return cell
        }
        
        
    }
    
    // MARK: - UITableViewDelegate

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
