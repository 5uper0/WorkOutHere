//
//  NameAndFieldTableCell.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/23/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit

class NameAndFieldTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(with labelText: String, placeholder: String, andText text: String) {
        
        nameLabel.text = labelText
        nameField.placeholder = placeholder
        nameField.text = text
    }
    
    func configureCell(with labelText: String, and placeholder: String) {
        configureCell(with: labelText, placeholder: placeholder, andText: "")
    }
}
