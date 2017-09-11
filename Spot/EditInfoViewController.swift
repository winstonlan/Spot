//
//  EditInfoViewController.swift
//  Spot
//
//  Created by William Khaine on 09/04/17.
//  Copyright © 2017 winstonlan. All rights reserved.
//
//  Transfers edits to in edit screen to data.

import UIKit


class EditInfoViewController: UIViewController {
    
    var name: String    = ""
    var amount: String  = ""
    
    var passedName: String?
    var passedAmount: String?
    var passedKey : String?
    
    // Useful in determine whether to update the server data
    var prelimName : String?
    var prelimAmount : String?
    
    @IBOutlet weak var amountLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        amountLabel.text = passedAmount
        nameLabel.text = passedName
        
        prelimName = nameLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        prelimAmount = amountLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        name = prelimName!
        amount = prelimAmount!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// Resets the name variable to be the stripped input. Changes upon 
    /// selecting a space outside of the UITextField.
    
    
    @IBAction func nameChanged(_ sender: Any) {
        print("Name changed from " + name + " to " + nameLabel.text!)
        name = nameLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    /// Resets the amount variable to be the stripped input. Changes upon
    /// selecting a space outside of the UITextField.
    @IBAction func amountChanged(_ sender: Any) {
        print("Amount changed from " + amount + " to " + amountLabel.text!)
        amount = amountLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    // MARK add back (i.e. cancel) button
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK add confirmButtonPressed
    @IBAction func updateButtonPressed(_ sender: Any) {
        print("Update button pressed")
        updateData()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /// Sends updated information to the model
    func updateData() {
        // Conditional check prevents user from accidentalty sending the
        // same information to the server
        if prelimName != name || prelimAmount != amount {
            print("Sending key \(passedKey!), name \(name), "
                + "and amount \(amount) to server")
            // Send data to server here
        } else {
            print("Constant information")
        }
    }
}

