//
//  HitMovingObjectViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 10/29/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

class HitMovingObjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func animateFish() {
        // create and add blue-fish.png image to screen
//        let fish = UIImageView()
//        fish.image = UIImage(named: "blue-fish.png")
//        fish.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
//        self.view.addSubview(fish)
//
        // create an array of views to animate (in this case just one)
//        let viewsToAnimate = [fish]
        
        // perform the system animation
        // as of iOS 8 UISystemAnimation.Delete is the only valid option
//        UIView.performSystemAnimation(UIView.SystemAnimation.Delete, onViews: viewsToAnimate, options: nil, animations: {
            // any changes defined here will occur
            // in parallel with the system animation
            
//        }, completion: { finished in
            // any code entered here will be applied
            // once the animation has completed
            
//        })
    }
}
