//
//  NameAndSegControlTableCell.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/23/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit

class NameAndSegControlTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionSegmentChanged(_ sender: UISegmentedControl) {
    }
    
    func configureCell(with labelText: String, firstTitle: String, andSecondTitle secondTitle: String) {
        
        nameLabel.text = labelText
        segControl.setTitle(firstTitle, forSegmentAt: 0)
        segControl.setTitle(secondTitle, forSegmentAt: 1)
    }
    
    func setSegment(with genderEnum: User.Gender) {
        
        if genderEnum != .unknown {
            segControl.selectedSegmentIndex = genderEnum.rawValue
        }
    }
}
