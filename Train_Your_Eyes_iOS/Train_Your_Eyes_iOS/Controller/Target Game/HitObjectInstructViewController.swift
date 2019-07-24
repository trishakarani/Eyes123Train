//
//  HitObjectInstructViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 7/23/19.
//  Copyright © 2019 Eyes123Train. All rights reserved.
//

import UIKit

class HitObjectInstructViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.replaceCurrentViewController(with: self, animated: false)
        title = "Hit Target Instructions"
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @IBAction func InstructToHitObject(_ sender: Any) {
        performSegue(withIdentifier: "goInstructToHitObject", sender: self)
    }
    
}
