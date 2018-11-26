//
//  AlertFunctions.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 11/19/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import Foundation
import UIKit

class AlertFunctions {
    class func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            print("OK Button Clicked")
        })
        alertController.addAction(OKAction)

        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center

        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: title as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Verdana", size: 22.0)!])
        alertController.setValue(myMutableString, forKey: "attributedTitle")

        var messageMutableString = NSMutableAttributedString()
        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Verdana", size: 18.0)!,
            NSAttributedString.Key.paragraphStyle: style])
        alertController.setValue(messageMutableString, forKey: "attributedMessage")

        var alertWindow : UIWindow!
        alertWindow = UIWindow.init(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController.init()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertController, animated: true)
    }
}
