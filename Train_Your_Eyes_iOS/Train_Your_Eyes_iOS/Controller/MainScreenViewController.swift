//
//  MainScreenViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 10/28/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

class MainScreenViewController: UITableViewController {

    let mainPageArray = ["Hit Moving Object", "Moving Eye Exercise", "OptoKinetic", "Vision Check"]
    let imageArray = ["hitMark", "lazyEye", "optoKinetic", "visionCheck"]
    var tablefontSize: Int = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.red,
             NSAttributedString.Key.font: UIFont(name: "Verdana", size: 22)!]

        print("frame=\(self.view.frame) , width=\(self.view.frame.width), height=\(self.view.frame.height)")
        if self.view.frame.height > 720 {
            self.tableView?.rowHeight = 140.0
            if self.view.frame.width > 400 {
                tablefontSize = 22
            }
            else {
                tablefontSize = 20
            }
        }
        else if self.view.frame.height > 660 {
            self.tableView?.rowHeight = 130.0
            tablefontSize = 22
        }
        else if self.view.frame.height > 560 {
            self.tableView?.rowHeight = 110.0
            tablefontSize = 18
        }
        
        self.navigationItem.setHidesBackButton(true,  animated:true)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mainPageArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuCell", for: indexPath) as! MainScreenTableViewCell
        
        cell.accessoryType = .none
        cell.menuImage?.image = UIImage(named: imageArray[indexPath.row])
        cell.menuName?.font = UIFont(name:"Verdana", size:CGFloat(tablefontSize))
        cell.menuName?.text = mainPageArray[indexPath.row]
        
        return cell
    }

    //MARK: - Table view Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "gotoHitMovingObject", sender: self)
        case 1:
            performSegue(withIdentifier: "gotoMovingBall", sender: self)
        case 2:
            performSegue(withIdentifier: "gotoOptoKinetic", sender: self)
        case 3:
            performSegue(withIdentifier: "gotoVisionCheck", sender: self)
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
