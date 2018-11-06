//
//  OptokineticViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 10/29/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

class OptokineticViewController: UIViewController {
    
    @IBOutlet weak var colorButton: UIBarButtonItem!
    var optoKColorStatus : Bool = false
    var buttonArray: [UIButton] = [UIButton]()

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func colorButtonPressed(_ sender: UIBarButtonItem) {
        optoKColorStatus = !optoKColorStatus
        setupColorButton()
    }

    func setupView() {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            setupLandscapeModeView()
        }
        else {
            setupPortraitModeView()
        }
    }
    
    func setupLandscapeModeView() {
    }
    
    func setupPortraitModeView() {
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        print("Stack View size \(size) from super view size \(stackView.frame.size)")
        
        let numBtns = Int(stackView.frame.height / 50)
        
        for btnIdx in 0..<numBtns {
            let yValue = btnIdx * 50
            let scrnButton = makeButton(yValue: yValue)
            buttonArray.append(scrnButton)
            stackView.addArrangedSubview(scrnButton)
            
            stackView.addConstraint(NSLayoutConstraint(item: scrnButton, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: stackView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
            stackView.addConstraint(NSLayoutConstraint(item: scrnButton, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: stackView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
        }
        
        self.view.addSubview(stackView)
        
//        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("Will Transition to size \(size) from super view size \(self.view.frame.size)")
        
        if (size.width > self.view.frame.size.width) {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }
    
    func makeButton(yValue: Int) -> UIButton {
        let myButton = UIButton(type: UIButton.ButtonType.system)
//        myButton.frame = CGRect(x: 0, y: yValue, width: 25, height: 20)
        myButton.backgroundColor = UIColor.black
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.heightAnchor.constraint(lessThanOrEqualToConstant: 15)
//        myButton.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
//        myButton.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        
        return myButton
    }
    
    func setupColorButton() {
        for btn in buttonArray {
            btn.backgroundColor = optoKColorStatus ? UIColor.red : UIColor.black
        }
        colorButton.tintColor = optoKColorStatus ? UIColor.black : UIColor.red
    }
}
