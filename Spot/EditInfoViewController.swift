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
    
    @IBOutlet weak var amountLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// Resets the name variable to be the stripped input. Changes upon selecting
    /// a space outside of the UITextField.
    @IBAction func nameChanged(_ sender: Any) {
        print("Name changed from " + name + " to " + nameLabel.text!)
        name = nameLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Resets the amount variable to be the stripped input. Changes upon
    /// selecting a space outside of the UITextField.
    @IBAction func amountChanged(_ sender: Any) {
        print("Amount changed from " + amount + " to " + amountLabel.text!)
        amount = nameLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

