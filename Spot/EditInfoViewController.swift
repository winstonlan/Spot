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
    
    var oblig : Obligation?
    
    // Useful in determine whether to update the server data
    var prelimName : String?
    var prelimAmount : String?
    
    @IBOutlet weak var amountLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        UINavigationBar.appearance().barTintColor = UIColor.red
        
        amountLabel.text = String(format: "$%.2f", Double((oblig?.amount)! / 100))
        amountLabel.keyboardType = .decimalPad
        
        nameLabel.text = oblig?.name
        
        prelimName = nameLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        prelimAmount = amountLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        name = prelimName!
        amount = prelimAmount!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.barTintColor = UIColor(
            red: 0.80, green: 0.42, blue: 0.90, alpha: 1.0)
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
    
    /// Dismisses keyboard upon touch outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    
    /// When the update button is pressed, this function is called to send 
    /// the attributes of an Obligation object to the server 
    @IBAction func updateButtonPressed(_ sender: Any) {
        print("Update button pressed")
        updateData()
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /// Sends updated information to the model
    func updateData() {
        // Prevent user from redudantly sending the same info
        if prelimName != name || prelimAmount != amount {
            print("Sending key \(String(describing: oblig?.key)), name \(name), "
                + "and amount \(amount) to server")
            // TODO Send data to server here
        } else {
            print("Information unchanged")
        }
    }
}

