//
//  MainScreenTableViewCell.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 10/30/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit


class MainScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var menuImage: UIImageView!
    
    @IBOutlet weak var menuName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        print("Button Pressed")
    }
    
}
