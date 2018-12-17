//
//  ContrastTestViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 11/22/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

class ContrastTestViewController: UIViewController {

    @IBOutlet weak var stack1Btn1: UIButton!
    @IBOutlet weak var stack1Btn2: UIButton!
    @IBOutlet weak var stack1Btn3: UIButton!
    
    @IBOutlet weak var stack2Btn1: UIButton!
    @IBOutlet weak var stack2Btn2: UIButton!
    @IBOutlet weak var stack2Btn3: UIButton!
    
    @IBOutlet weak var stack3Btn1: UIButton!
    @IBOutlet weak var stack3Btn2: UIButton!
    @IBOutlet weak var stack3Btn3: UIButton!
    
    var colorBlindnessResult: String = ""
    
    var contrastColorButtons: [UIButton] = []
    
    var acuityTestResult: String = ""
    var vision2020Result: String = ""
    var contrastSuccessCount: Int = 0
    var contrastTestCount: Int = 0
    var contrastBtnTagId: Int = 0
    
    var Instructions: String = "\r\n\r\nIn this test we test how you distinguish contrast in the colors.\r\n\r\nKeep the device at a suggested distance of 16 inches from your eyes. You should choose the square box whose color contrasts in the picture.\r\n\r\n"

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        AlertFunctions.showAlert(title: "Color Contrast Test", message: Instructions)
        addButtonsToList()
        
        setupContrastColorButtons()
        self.navigationController?.replaceCurrentViewController(with: self, animated: false)
    }
    
    func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        self.navigationController?.popViewController(animated: true)
    }

    func addButtonsToList() {
        contrastColorButtons.append(stack1Btn1)
        contrastColorButtons.append(stack1Btn2)
        contrastColorButtons.append(stack1Btn3)
        contrastColorButtons.append(stack2Btn1)
        contrastColorButtons.append(stack2Btn2)
        contrastColorButtons.append(stack2Btn3)
        contrastColorButtons.append(stack3Btn1)
        contrastColorButtons.append(stack3Btn2)
        contrastColorButtons.append(stack3Btn3)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func buttonClicked(_ sender: UIButton) {
        if contrastBtnTagId == sender.tag {
            contrastSuccessCount += 1
        }
        if contrastTestCount > 10 {
            displayVisionTestResults()
        }
        setupContrastColorButtons()
    }
    
    func setupContrastColorButtons() {
        let colorTest: UIColor = .random()
        let posBrightness = Int.random(in: 15...50)
        let randomBrightness = contrastTestCount%2 == 0 ? posBrightness : -1*posBrightness
        let contrastColor: UIColor = colorTest.adjustBrightness(by: CGFloat(randomBrightness))
        let colorContrastIdx = Int.random(in: 0..<contrastColorButtons.count)
        
        for btnIdx in 0 ..< contrastColorButtons.count {
            if btnIdx == colorContrastIdx {
                contrastColorButtons[btnIdx].backgroundColor = contrastColor
                contrastBtnTagId = colorContrastIdx + 1
            }
            else {
                contrastColorButtons[btnIdx].backgroundColor = colorTest
            }
        }
        contrastTestCount += 1
    }

    func displayVisionTestResults() {
        performSegue(withIdentifier: "visionResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VisionTestResultsViewController {
            let vc = segue.destination as? VisionTestResultsViewController
            vc?.acuityTestResult = self.acuityTestResult
            vc?.vision2020Result = self.vision2020Result
            vc?.colorContrastResult = "\(contrastSuccessCount) of \(contrastTestCount)"
            vc?.colorBlindnessResult = self.colorBlindnessResult
        }
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }

    /**
     Create a lighter color
     */
    public func lighter(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: abs(percentage))
    }
    
    /**
     Create a darker color
     */
    public func darker(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: -abs(percentage))
    }
    
    /**
     Changing R, G, B values
     */
    
    func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            
            let pFactor = (100.0 + percentage) / 100.0
            
            let newRed = (red*pFactor).clamped(to: 0.0 ... 1.0)
            let newGreen = (green*pFactor).clamped(to: 0.0 ... 1.0)
            let newBlue = (blue*pFactor).clamped(to: 0.0 ... 1.0)
            
            return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
        }
        
        return self
    }
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        
        if self > range.upperBound {
            return range.upperBound
        } else if self < range.lowerBound {
            return range.lowerBound
        } else {
            return self
        }
    }
}

extension UINavigationController {
    func replaceCurrentViewController(with viewController: UIViewController, animated: Bool) {
        let indexToRemove = viewControllers.count - 2
        if indexToRemove >= 0 {
            viewControllers.remove(at: indexToRemove)
        }
    }
}
