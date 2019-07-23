//
//  MovingBallInstructionsViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 7/23/19.
//  Copyright © 2019 Eyes123Train. All rights reserved.
//

import UIKit

class MovingBallInstructionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationController?.replaceCurrentViewController(with: self, animated: false)
    }
    
    @IBAction func InstructToMovingBall(_ sender: Any) {
        performSegue(withIdentifier: "goInstructToMovingBall", sender: self)
    }
    

}
