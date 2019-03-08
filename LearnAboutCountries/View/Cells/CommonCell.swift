//
//  CommonCell.swift
//  LearnAboutCountries
//
//  Created by Iryna Pfeiffer on 3/4/19.
//  Copyright © 2019 Iryna Pfeiffer. All rights reserved.
//

import UIKit

class CommonCell: UITableViewCell {
    

    @IBOutlet weak var propertyName: UILabel!
    
    @IBOutlet weak var propertyValue: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

