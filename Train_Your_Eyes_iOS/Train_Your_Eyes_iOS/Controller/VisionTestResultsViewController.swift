//
//  VisionTestResultsViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 11/19/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

class VisionTestResultsViewController: UIViewController {

    //@IBOutlet weak var blindnessResult: UILabel!
    @IBOutlet weak var visionResult: UILabel!
    @IBOutlet weak var shapeResult: UILabel!
    @IBOutlet weak var contrastResult: UILabel!
    
//    var acuityTestResult: String = ""
//    var vision2020Result: String = ""
    //var colorBlindnessResult: String = ""
    var colorContrastResult: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
//
//        self.navigationController?.navigationBar.titleTextAttributes =
//            [NSAttributedString.Key.foregroundColor: UIColor.red,
//             NSAttributedString.Key.font: UIFont(name: "Verdana", size: 22)!]
        
        updateResults()
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        performSegue(withIdentifier: "gotoMainScreen", sender: self)
    }
    
    func updateResults() {
        //blindnessResult.text = colorBlindnessResult
//        visionResult.text = acuityTestResult
//        shapeResult.text = vision2020Result
        contrastResult.text = colorContrastResult

       // print("Vision Results: \(colorBlindnessResult)")
//        print("Vision Results: \(acuityTestResult)")
//        print("Vision Results: \(vision2020Result)")
        print("Vision Results: \(colorContrastResult)")
    }
}
