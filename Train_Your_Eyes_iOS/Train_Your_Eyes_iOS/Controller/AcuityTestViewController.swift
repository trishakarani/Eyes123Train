//
//  AcuityTestViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Vijay Karani on 11/23/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

var Instructions: String = "\r\n\r\nIn this test we test how well you see alphabets of different sizes and shapes. \r\nKeep the device at a safe distance from your eyes. Choose the option box whose shape match with the one in the picture.\r\n\r\n"

class AcuityTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        AlertFunctions.showAlert(title: "Acuity Test", message: Instructions)
        
        self.navigationController?.replaceCurrentViewController(with: self, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
