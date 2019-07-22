//
//  ViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 10/14/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit
import ResearchKit

class ViewController: UIViewController, ORKTaskViewControllerDelegate {

    
   override func viewDidLoad() {
        super.viewDidLoad()
    
        let taskViewController = ORKTaskViewController(task: TrainYourEyesConsentTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        taskViewController.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "gotoMainCollectionScreen", sender: self)
    }
}

