//
//  WhoYouOweViewController.swift
//  Spot
//
//  Created by Winston Lan on 9/7/17.
//  Copyright © 2017 winstonlan. All rights reserved.
//

import UIKit
import Firebase

class WhoYouOweViewController: UITableViewController {
    
    // MARK: Properties
    var obligations: [Obligation] = []
    var user: User!
    var ref: DatabaseReference!
    
    var index : Int = 0
    var personsName: String = ""
    var amountToPay: String = ""
    
    
    // MARK: UITableViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")
        
        user = User(uid: "FakeId", email: "user1@spot.com")
        
        ref.child(
            "\(user.uid)/debt").observe(
                DataEventType.value,
                with: { (snapshot) in
            var newObligations: [Obligation] = []
            
            for item in snapshot.children {
                let obligationItem = Obligation(snapshot: item as! DataSnapshot)
                newObligations.append(obligationItem)
            }
            
            self.obligations = newObligations
            self.tableView.reloadData()
        })
    }

    
    // MARK: UITableView Delegate methods
    override func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return obligations.count
    }
    
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ObligationCell", for: indexPath)
            as! CustomTableViewCell
        
        let obligationItem = obligations[indexPath.row]
        
        cell.personsName?.text = obligationItem.name
        cell.amount?.text = String(
            format: "$%.2f", Double(obligationItem.amount / 100))
        
        return cell
    }
    
    // MARK: Add Obligation
    func addButtonDidTouch() {
        let debt = Obligation(
            name: "John Doe", amount: 300, addedByUser: user.email,
            completed: false)
        
        ref.child(
            "\(user.uid)/debt").childByAutoId().setValue(debt.toAnyObject())
    }
    
    
    /// Perform segue over to the Edit View Controller
    @IBAction func editButtonPressed(_ sender: UIButton) {
        // Get the index by tag
        index = sender.tag
        print("Index is now \(index)")
        performSegue(withIdentifier: "toEditScreen", sender: self)
    }
    
    
    /// Loads destination view controller with the name and amount of 
    /// the obligation to edit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditScreen" {
            let destinationVC = segue.destination as! EditInfoViewController
            
            destinationVC.passedName    = obligations[index].name
            destinationVC.passedAmount  = String(
                format: "%.2f", Double(obligations[index].amount / 100))
            destinationVC.passedKey           = obligations[index].key
        }
    }
    
}
