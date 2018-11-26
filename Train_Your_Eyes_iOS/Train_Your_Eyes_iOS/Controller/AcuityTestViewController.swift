//
//  AcuityTestViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 11/23/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

var Instructions: String = "\r\n\r\nIn this test we test how well you see alphabets of different sizes and shapes. \r\n\r\nKeep the device at a safe distance from your eyes. Choose the option box whose shape match with the one in the picture.\r\n\r\n"

class AcuityTestViewController: UIViewController {

    
    @IBOutlet weak var testBkgdView: UIView!
    var testCharacterView: UIView!
    var characterLabel: UILabel!
    
    @IBOutlet weak var optionsBtn1: RoundButton!
    @IBOutlet weak var optionsBtn2: RoundButton!
    @IBOutlet weak var optionsBtn3: RoundButton!
    @IBOutlet weak var optionsBtn4: RoundButton!
    
    var colorBlindnessResult: String = ""
    var colorContrastResult: String = ""
    
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
        
        let labelWidth = testBkgdView.frame.width
        let labelHeight = testBkgdView.frame.height
        characterLabel = UILabel(frame: CGRect(x: 0, y: 0, width: labelWidth, height: labelHeight))
        testBkgdView.addSubview(characterLabel)

        setupAcuityTest()
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
    
    @IBAction func optionsButtonClicked(_ sender: UIButton) {
        if acuityTestCount > 10 {
            displayVisionTestResults()
        }
        if sender.tag == (correctChoiceIdx+1) {
            acuitySuccessCount += 1
            if currVisionTestLevel < (visionTest.count-1) {
                currVisionTestLevel += 1
            }
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
        characterLabel.font = UIFont(name: "Verdana", size: CGFloat(inputValues.fontSize))

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
    
    func displayVisionTestResults() {
        performSegue(withIdentifier: "visionResults", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VisionTestResultsViewController {
            let vc = segue.destination as? VisionTestResultsViewController
            vc?.acuityTestResult = "\(acuitySuccessCount) of \(acuityTestCount)"
            vc?.vision2020Result = correctedVision
            vc?.colorContrastResult = self.colorContrastResult
            vc?.colorBlindnessResult = self.colorBlindnessResult
        }
    }
}
