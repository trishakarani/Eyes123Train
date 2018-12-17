//
//  MainPageViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 10/20/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

class VisionCheckViewController: UIViewController {

    @IBOutlet weak var blindnessImg: UIImageView!
    var currTestIndex : Int = 0
    var correctChoiceIdx : Int = 0
    
    var correctCount : Int = 0
    
    @IBOutlet weak var choiceBtn1: UIButton!
    @IBOutlet weak var choiceBtn2: UIButton!
    @IBOutlet weak var choiceBtn3: UIButton!
    @IBOutlet weak var choiceBtn4: UIButton!
    
    var acuityTestResult: String = ""
    var vision2020Result: String = ""

    var Instructions: String = "\r\n\r\nIn this test we test how you distinguish between red, green and blue colors. \r\n\r\nKeep the device at a suggested distance of 16 inches from your eyes. You should choose the figure that you see in the picture.\r\n\r\n"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.red,
             NSAttributedString.Key.font: UIFont(name: "Verdana", size: 22)!]
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        AlertFunctions.showAlert(title: "Color Blindness Test", message: Instructions)

        updateNewColorTest()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func userNumberSelected(_ sender: UIButton) {
        if correctChoiceIdx == (sender.tag - 1) {
            correctCount += 1
        }
         updateNewColorTest()
    }
    
    func updateNewColorTest() {
        if currTestIndex > 8 {
            colorContrastTest()
        }
        else if currTestIndex % 4 == 0 {
            let randomTestIdx = Int.random(in: 1 ... colorBlindNothingSet.count)
            let currentTestData = colorBlindNothingSet[randomTestIdx]
            setScreenData(testData: currentTestData!)
            currTestIndex += 1
        }
        else {
            let randomTestIdx = Int.random(in: 1 ... colorBlindNumberSet.count)
            let currentTestData = colorBlindNumberSet[randomTestIdx]
            setScreenData(testData: currentTestData!)
            currTestIndex += 1
        }
    }
    
    func setScreenData(testData: ColorBlindData) {
        blindnessImg.image = UIImage(named: testData.imgName)
        
        correctChoiceIdx = Int.random(in: 0..<4)
        switch correctChoiceIdx {
        case 0:
            choiceBtn1.setTitle(testData.choices[2], for: UIControl.State.normal)
            choiceBtn2.setTitle(testData.choices[1], for: UIControl.State.normal)
            choiceBtn3.setTitle(testData.choices[0], for: UIControl.State.normal)
            choiceBtn4.setTitle(testData.choices[3], for: UIControl.State.normal)
        case 1:
            choiceBtn1.setTitle(testData.choices[0], for: UIControl.State.normal)
            choiceBtn2.setTitle(testData.choices[2], for: UIControl.State.normal)
            choiceBtn3.setTitle(testData.choices[1], for: UIControl.State.normal)
            choiceBtn4.setTitle(testData.choices[3], for: UIControl.State.normal)
        case 2:
            choiceBtn1.setTitle(testData.choices[0], for: UIControl.State.normal)
            choiceBtn2.setTitle(testData.choices[1], for: UIControl.State.normal)
            choiceBtn3.setTitle(testData.choices[2], for: UIControl.State.normal)
            choiceBtn4.setTitle(testData.choices[3], for: UIControl.State.normal)
        case 3:
            choiceBtn1.setTitle(testData.choices[0], for: UIControl.State.normal)
            choiceBtn2.setTitle(testData.choices[1], for: UIControl.State.normal)
            choiceBtn3.setTitle(testData.choices[3], for: UIControl.State.normal)
            choiceBtn4.setTitle(testData.choices[2], for: UIControl.State.normal)
        default:
            choiceBtn1.setTitle(testData.choices[2], for: UIControl.State.normal)
            choiceBtn2.setTitle(testData.choices[1], for: UIControl.State.normal)
            choiceBtn3.setTitle(testData.choices[0], for: UIControl.State.normal)
            choiceBtn4.setTitle(testData.choices[3], for: UIControl.State.normal)
        }
    }
    
    func colorContrastTest() {
        performSegue(withIdentifier: "contrastTest", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ContrastTestViewController {
            let vc = segue.destination as? ContrastTestViewController
            vc?.colorBlindnessResult = "\(correctCount) of \(currTestIndex)"
            vc?.acuityTestResult = self.acuityTestResult
            vc?.vision2020Result = self.vision2020Result
        }
    }
}
