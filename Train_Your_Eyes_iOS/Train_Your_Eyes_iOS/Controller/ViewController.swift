//
//  ViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Vijay Karani on 10/14/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let agreementString = "This is a research app. It is not meant for diagnostic or treatment of any diseases. \r\n\r\nThere have been many medical research carried out to improve the vision of humans. We are using the research work to help the community. The data collected during the research work is going to be used for medical analysis. \r\n\r\nWe will maintain the confidentiality of our customers results, and no personal data will be shared.\r\n\r\nPlease Click on \"I Accept\" for having made aware of the Agreement."
    
    @IBOutlet weak var agreementTerms: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAgreementTerms()
    }

    func addAgreementTerms() {
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        let attrString = NSAttributedString(string: agreementString, attributes: attrs)
        
        agreementTerms.attributedText = attrString
    }
}

