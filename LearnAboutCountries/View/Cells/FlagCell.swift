//
//  FlagCell.swift
//  LearnAboutCountries
//
//  Created by Iryna Pfeiffer on 3/5/19.
//  Copyright © 2019 Iryna Pfeiffer. All rights reserved.
//

import UIKit
import WebKit

class FlagCell: UITableViewCell {


    @IBOutlet weak var flagImage: WKWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showSVG(url: String){
        guard let url = URL(string: url) else {return}
        let request = URLRequest(url: url) 
              flagImage.load(request)
        

    }
}
