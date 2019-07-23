//
//  OKNInstructionsViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 7/23/19.
//  Copyright © 2019 Eyes123Train. All rights reserved.
//

import UIKit

class OKNInstructionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let backButton = UIBarButtonItem()
//        backButton.title = "Back"
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.replaceCurrentViewController(with: self, animated: false)
       
        // Do any additional setup after loading the view.
    }
    @IBAction func InstructToOKN(_ sender: Any) {
        performSegue(withIdentifier: "goInstructToOKN", sender: self)
    }
        

    
}
