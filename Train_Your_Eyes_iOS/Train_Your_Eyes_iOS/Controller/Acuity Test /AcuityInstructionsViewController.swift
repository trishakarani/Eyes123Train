//
//  AcuityInstructionsViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 7/23/19.
//  Copyright © 2019 Eyes123Train. All rights reserved.
//

import UIKit

class AcuityInstructionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func InstructToAcuity(_ sender: Any) {
        performSegue(withIdentifier: "goInstructToAcuity", sender: self)
    }
    

}
