//
//  AcuityTestViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 11/23/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

//var Instructions: String = "\r\n\r\nIn this test we test how well you see alphabets of different sizes and shapes. \r\n\r\nKeep the device at a suggested distance of 16 inches from your eyes. Choose the option box whose shape match with the one in the picture.\r\n\r\n"

class AcuityTestViewController: UIViewController {

    
    @IBOutlet weak var testBkgdView: UIView!
    @IBOutlet weak var characterLabel: UILabel!
    
    @IBOutlet weak var optionsBtn1: RoundButton!
    @IBOutlet weak var optionsBtn2: RoundButton!
    @IBOutlet weak var optionsBtn3: RoundButton!
    @IBOutlet weak var optionsBtn4: RoundButton!
    
//    var colorBlindnessResult: String = ""
//    var colorContrastResult: String = ""
    
    var acuitySuccessCount: Int = 0
    var acuityTestCount: Int = 0
    var acuityBtnTagId: Int = 0
    
    var prevTestResult: Bool = false
    var currVisionTestLevel: Int = 0
    var correctChoiceIdx: Int = 0
    var correctedVision: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        setupAcuityTest()
//        AlertFunctions.showAlert(title: "Acuity Test", message: Instructions)
        
        //not necessary
        //self.navigationController?.replaceCurrentViewController(with: self, animated: false)
    }
    
    
    @IBAction func optionsButtonClicked(_ sender: UIButton) {
        
        if sender.tag == (correctChoiceIdx+1) {
            acuitySuccessCount += 1
            if currVisionTestLevel < (visionTest.count-1) {
                currVisionTestLevel += 1
            }
        }
        
        if acuityTestCount > 3 {
            moveToColorContrastTest()
        }
        
        setupAcuityTest()
    }
    
    func setupAcuityTest() {
        let randomTestIdx = Int.random(in: 0..<visionTest[currVisionTestLevel].count)
        let currVisionTest: AcuityTestData = visionTest[currVisionTestLevel][randomTestIdx]
        
        generateTestData(inputValues: currVisionTest)
    
        acuityTestCount += 1
    }
    
    func generateTestData(inputValues: AcuityTestData) {

        characterLabel.textAlignment = .center //For center alignment
        characterLabel.text = inputValues.alphValue
        characterLabel.textColor = .white
        characterLabel.backgroundColor = .darkGray
//        characterLabel.font = UIFont(name: "Verdana", size: CGFloat(inputValues.fontSize))
        
        correctedVision = inputValues.correctedVision
        correctChoiceIdx = Int.random(in: 0..<4)
        switch correctChoiceIdx {
        case 0:
            optionsBtn1.setTitle(inputValues.choices[2], for: UIControl.State.normal)
            optionsBtn2.setTitle(inputValues.choices[1], for: UIControl.State.normal)
            optionsBtn3.setTitle(inputValues.choices[0], for: UIControl.State.normal)
            optionsBtn4.setTitle(inputValues.choices[3], for: UIControl.State.normal)
        case 1:
            optionsBtn1.setTitle(inputValues.choices[0], for: UIControl.State.normal)
            optionsBtn2.setTitle(inputValues.choices[2], for: UIControl.State.normal)
            optionsBtn3.setTitle(inputValues.choices[1], for: UIControl.State.normal)
            optionsBtn4.setTitle(inputValues.choices[3], for: UIControl.State.normal)
        case 2:
            optionsBtn1.setTitle(inputValues.choices[0], for: UIControl.State.normal)
            optionsBtn2.setTitle(inputValues.choices[1], for: UIControl.State.normal)
            optionsBtn3.setTitle(inputValues.choices[2], for: UIControl.State.normal)
            optionsBtn4.setTitle(inputValues.choices[3], for: UIControl.State.normal)
        case 3:
            optionsBtn1.setTitle(inputValues.choices[0], for: UIControl.State.normal)
            optionsBtn2.setTitle(inputValues.choices[1], for: UIControl.State.normal)
            optionsBtn3.setTitle(inputValues.choices[3], for: UIControl.State.normal)
            optionsBtn4.setTitle(inputValues.choices[2], for: UIControl.State.normal)
        default:
            optionsBtn1.setTitle(inputValues.choices[2], for: UIControl.State.normal)
            optionsBtn2.setTitle(inputValues.choices[1], for: UIControl.State.normal)
            optionsBtn3.setTitle(inputValues.choices[0], for: UIControl.State.normal)
            optionsBtn4.setTitle(inputValues.choices[3], for: UIControl.State.normal)
        }
    }

    func moveToColorContrastTest() {
        performSegue(withIdentifier: "acuityResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AcuityTestResultsViewController  {
            let vc = segue.destination as? AcuityTestResultsViewController
            vc?.acuityTestResult = "\(acuitySuccessCount) of \(acuityTestCount)"
            vc?.vision2020Result = correctedVision
        }
    }
}



