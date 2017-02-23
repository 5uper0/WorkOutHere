//
//  ButtonTableCell.swift
//  WorkOutThere
//
//  Created by Oleh Veheria on 2/23/17.
//  Copyright © 2017 Oleh Veheria. All rights reserved.
//

import UIKit

class ButtonTableCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func actionButton(_ sender: UIButton) {
    }
    
}
