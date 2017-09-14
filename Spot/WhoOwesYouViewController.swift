//
//  WhoOwesYouViewController.swift
//  Spot
//
//  Created by Winston Lan on 9/7/17.
//  Copyright © 2017 winstonlan. All rights reserved.
//

import UIKit
import Firebase

class WhoOwesYouViewController: UITableViewController {
    
    // Useful for determining which obligation to send to the Edit Screen  
    var obligations: [Obligation] = []
    var user: User!
    var ref: DatabaseReference!
    
    /// Useful in selecting which obligation to edit
    var index : Int = 0
    var PayerName: String = ""
    var amountToReceive: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.barTintColor = UIColor(
            red: 0.29, green: 0.66, blue: 0.35, alpha: 1.0)
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [
                NSFontAttributeName: UIFont(name: "Avenir", size: 32)!,
                NSForegroundColorAttributeName: UIColor.white
            ]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// Upon being pressed, this function is called. It initiates a segue over 
    /// to the Edit Screen.
    @IBAction func onEditButonPressed(_ sender: UIButton) {
        let editBtnCoords = sender.convert(CGPoint(), to: tableView)
        index = tableView.indexPathForRow(at: editBtnCoords)![1]
        print("Index is now \(index)")
        performSegue(withIdentifier: "toEditScreenR", sender: self)
    }
    
    
    /// Submits the obligation to edit to the screen that will be segued.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditScreenR" {
            let destinationVC = segue.destination as! EditInfoViewController
            destinationVC.oblig    = obligations[index]
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
