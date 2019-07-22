//
//  MainScreenViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 10/28/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit
import ResearchKit

class MainScreenViewController: UICollectionViewController {

    let frontLabelArray = ["Line Dancers", "Follow Me", "Targets", "Check It Out"]
    let frontImageArray = [UIImage(named: "optokineticBlankCircle"),  UIImage(named:"movingBallBlankCircle"), UIImage(named:"hitTargetBlankCircle"), UIImage(named: "visionCheckBlankCircle")]
    var tablefontSize: Int = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize( width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/4)

//        self.navigationController?.navigationBar.titleTextAttributes =
//            [NSAttributedString.Key.foregroundColor: UIColor.red,
//             NSAttributedString.Key.font: UIFont(name: "Verdana", size: 22)!]

        print("frame=\(self.view.frame) , width=\(self.view.frame.width), height=\(self.view.frame.height)")
        
        self.navigationItem.setHidesBackButton(true,  animated:true)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frontImageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "frontCell", for: indexPath) as! MainScreenCollectionViewCell
        
        cell.frontLabel.text = frontLabelArray[indexPath.item]
        cell.frontImage.image = frontImageArray[indexPath.item]
        
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "gotoOptoKinetic", sender: self)
        case 1:
            performSegue(withIdentifier: "gotoMovingBall", sender: self)
        case 2:
            performSegue(withIdentifier: "gotoHitMovingObject", sender: self)
        case 3:
            performSegue(withIdentifier: "gotoVisionCheck", sender: self)
        
//        case 4:
//            performSegue(withIdentifier: "gotoLandoltCAcuity", sender: self)
//        case 5:
//            performSegue(withIdentifier: "gotoLandoltCContrast", sender: self)
        default:
            performSegue(withIdentifier: "gotoOptoKinetic", sender: self)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
