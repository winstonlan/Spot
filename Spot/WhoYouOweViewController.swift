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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.barTintColor = UIColor(
            red: 0.24, green: 0.57, blue: 1.0, alpha: 1.0)
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "Avenir", size: 32)!,
            NSForegroundColorAttributeName: UIColor.white
        ]
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
        cell.amount?.text = "$\(obligationItem.toDollarAmount())"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let obligationItem = self.obligations[index.row]
            obligationItem.ref?.removeValue()
            print("Delete button tapped")
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.editButtonDidTouch(rowIndex: index.row)
            print("edit button tapped")
        }

        delete.backgroundColor = .red
        edit.backgroundColor = .lightGray
        
        return [delete, edit]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: Add Obligation
    @IBAction func addButtonDidTouch(_ sender: Any) {

        let alert = UIAlertController(title: "Obligation",
                                      message: "Add Payable Transaction",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Add", style: .default)
        { _ in
            let nameText = alert.textFields![0]
            let amountText = alert.textFields![1]
            
            let debt = Obligation(
                name: nameText.text!,
                amount: self.dollarsToCents(amount: Double(amountText.text!)!),
                addedByUser: self.user.email,
                completed: false)
            
            self.ref.child("\(self.user.uid)/debt").childByAutoId().setValue(debt.toAnyObject())
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Username"
        }
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "0.00"
            textField.keyboardType = .decimalPad
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //: MARK: Edit Obligation
    func editButtonDidTouch(rowIndex: Int) {
        let obligationItem = self.obligations[rowIndex]
        let key = obligationItem.ref!
        print("KEY: \(key)")
        
        let alert = UIAlertController(title: "Obligation",
                                      message: "Edit Payable Transaction",
                                      preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.text = obligationItem.name
        }
        
        alert.addTextField { (textField: UITextField) in
            textField.text = obligationItem.toDollarAmount()
            textField.keyboardType = .decimalPad
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default)
        { _ in
            let nameText = alert.textFields![0]
            let amountText = alert.textFields![1]
            
            let debt = Obligation(
                name: nameText.text!,
                amount: self.dollarsToCents(amount: Double(amountText.text!)!),
                addedByUser: self.user.email,
                completed: false)
            
            key.setValue(debt.toAnyObject())
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Segue Methods
    @IBAction func editButtonPressed(_ sender: UIButton) {
        let editBtnCoords = sender.convert(CGPoint(), to: tableView)
        index = tableView.indexPathForRow(at: editBtnCoords)![1]
        print("Index is now \(index)")
        performSegue(withIdentifier: "toEditScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditScreen" {
            let destinationVC = segue.destination as! EditInfoViewController
            destinationVC.oblig    = obligations[index]
        }
    }
    
    // MARK: Helper Methods
    func dollarsToCents(amount: Double) -> Int {
        return Int( amount * 100 )
    }
    
}
