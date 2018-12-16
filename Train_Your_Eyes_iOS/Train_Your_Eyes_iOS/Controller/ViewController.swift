//
//  ViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 10/14/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    let agreementString = "This is a research app. It is not meant for diagnosis or treatment of any diseases. \r\n\r\nThere have been much medical research carried out to improve the vision of humans. We are using the research work to train eye-muscle and help users in Presybyopia and vision improvement. The data collected during research work is going to be used for medical analysis. \r\n\r\nWe maintain the confidentiality of our user results, and no personal data will be shared.\r\n\r\nPlease Click on \"I Accept\" for agreeing to these terms and conditions.\r\n\n© Research on Eyes"
    
    @IBOutlet weak var agreementTerms: UITextView!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.agreementTerms.delegate = self
        
        addAgreementTerms()
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "TermsAccepted")
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    func addAgreementTerms() {
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        let attrString = NSAttributedString(string: agreementString, attributes: attrs)
        
        agreementTerms.attributedText = attrString
    }
}

