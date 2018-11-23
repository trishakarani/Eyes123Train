//
//  VisionTestResultsViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 11/19/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

class VisionTestResultsViewController: UIViewController {

    @IBOutlet weak var blindnessResult: UILabel!
    @IBOutlet weak var visionResult: UILabel!
    @IBOutlet weak var shapeResult: UILabel!
    @IBOutlet weak var contrastResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true

        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.red,
             NSAttributedString.Key.font: UIFont(name: "Verdana", size: 22)!]
        
        updateResults()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateResults() {
        blindnessResult.text = "6 of 8"
        visionResult.text = "5 of 6"
        shapeResult.text = "4 of 6"
        contrastResult.text = "7 of 9"
    }
}
