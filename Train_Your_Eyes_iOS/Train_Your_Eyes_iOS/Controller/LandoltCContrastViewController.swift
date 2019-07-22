////
////  LandoltCContrastViewController.swift
////  Train_Your_Eyes_iOS
////
////  Created by Trisha Karani on 7/20/19.
////  Copyright © 2019 Eyes123Train. All rights reserved.
////
//
//import UIKit
//import ResearchKit
//
//class LandoltCContrastViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    // create a landoltC peak contrast sensitivity step
//    let cContrastStep = ORKLandoltCStep(identifier: "ContrastSensitivity", testType: .contrastSensitivity , eyeToTest: .right)
//    //step.testType = .contrastSensitivity
//    
//    // create an active task by passing in the step
//    let cContrastTask = ORKOrderedTask(identifier: "ContrastSensitivityTask", steps: [cContrastStep])
//    let cContrastTaskVC = ORKTaskViewController(task: cContrastTask, taskRun: UUID())
//    present(cContrastTaskVC, true, nil)
//}
//
//
//
//
//
//
//
