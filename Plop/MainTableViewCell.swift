//
//  MainTableViewCell.swift
//  Plop
//
//  Created by 김혜원 on 2016. 8. 27..
//  Copyright © 2016년 seolheelee. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var statusImageView: UIImageView!

    @IBOutlet weak var statusImageLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
}
