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
        title = "Line Dancers Instructions"

        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        //self.navigationController?.replaceCurrentViewController(with: self, animated: false)
       
        // Do any additional setup after loading the view.
    }

/*    @objc func backAction() {
        // Go back to the previous ViewController
        self.navigationController?.popViewController(animated: true)
    }*/
    
    @IBAction func InstructToOKN(_ sender: Any) {
        performSegue(withIdentifier: "goInstructToOKN", sender: self)
    }
}

extension UINavigationController {
    /*func replaceCurrentViewController(with viewController: UIViewController, animated: Bool) {
     let indexToRemove = viewControllers.count - 1
     if indexToRemove >= 0 {
     viewControllers.remove(at: indexToRemove)
     }
     }*/
}
