//
//  RoundButton.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 11/19/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }

    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }

    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }
}
