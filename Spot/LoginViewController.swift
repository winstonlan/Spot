//
//  LoginViewController.swift
//  Spot
//
//  Created by William Khaine on 09/20/17.
//  Copyright © 2017 winstonlan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// Determines if user name and password input are already extant in the 
    /// server. Segues to the rest of the application if so. An alert pops up 
    /// otherwise, prompting the user to reenter accurate information.
    @IBAction func loginButtonPressed(_ sender: Any) {
        if nonEmpty() {
            if validateLogin() {
                performSegue(withIdentifier: "passesLogin", sender: self)
            } else {
               generateInvalidInputAlert(
                title_: "Login Failed",
                message_: "The username and/or password entered was incorrect.")
            }
        } else {
            generateNoInputAlert()
        }
    }
    
    /// Determines if user name and password input are unique. Segues to the
    /// rest of the application if so. An alert pops up otherwise, prompting
    /// the user to reenter accurate information.
    @IBAction func signupButtonPressed(_ sender: Any) {
        if nonEmpty() {
            if uniqueUsername() {
                createAccount()
                performSegue(withIdentifier: "passesLogin", sender: self)
            } else {
                generateInvalidInputAlert(
                    title_: "Sign Up Failed",
                    message_: "Please enter another username.")
            }
        } else {
            generateNoInputAlert()
        }
        
    }
    
    /// Dismisses keyboard upon touch outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    /// Helper function to display an alert instance when non-empty invalid 
    /// input is provided.
    func generateInvalidInputAlert(title_: String, message_: String) {
        let alert = UIAlertController(
            title: title_,
            message: message_,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "Ok",
            style: .default,
            handler: { (action) -> Void in })) // do nothing
        present(alert, animated: true, completion: nil)
    }
    
    /// Helper function to display an alert instance when no input is provided.
    func generateNoInputAlert() {
        let noInput = UIAlertController(
            title: "A Field was Left Empty",
            message: "You'll have to try harder than that.",
            preferredStyle: .alert)
        noInput.addAction(UIAlertAction(
            title: "Ok",
            style: .default,
            handler: { (action) -> Void in })) // do nothing
        present(noInput, animated: true, completion: nil)
    }
    
    /// Returns true if the input is all whitespace
    func isAllWhitespace(word: String) -> Bool {
        return word.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    /// Returns true if login is non empty. False otherwise
    func nonEmpty() -> Bool {
        let filledUser  = !isAllWhitespace(word: usernameField.text!)
        let filledPw    = !isAllWhitespace(word: passwordField.text!)
        return filledUser && filledPw
    }
    
    
    /// Returns true if login values are valid. That is, if the username
    /// is paired with the password. Right now, non empty input passes.
    func validateLogin() -> Bool {
        print("Username: " + usernameField.text!)
        print("Password: " + passwordField.text!)
        return nonEmpty()
    }
    
    /// Returns true if the username is not yet in the server, false otherwise. 
    /// Right now, non empty input passes.
    func uniqueUsername() -> Bool {
        print("Username: " + usernameField.text!)
        print("Password: " + passwordField.text!)
        return nonEmpty()
    }
    
    /// Returns void. Saves a new account to the server.
    func createAccount() {
        let user = usernameField.text!
        let pw = usernameField.text!
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passesLogin" {
            let destinationVC = segue.destination as! UITabBarController
            // Use this function to pass user information (e.g. id) over to the
            // Payables/Receivables to retrieve the relevant Obligation objects.
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
