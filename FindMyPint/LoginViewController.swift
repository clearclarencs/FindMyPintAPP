//
//  LoginViewController.swift
//  FindMyPint
//
//  Created by James Skipworth on 04/03/2024.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordBox: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var viewPasswordButton: UIButton!
    @IBOutlet weak var usernameBox: UITextField!
    @IBOutlet weak var emailaddressBox: UITextField!
    @IBOutlet weak var messageBox: UILabel!
    
    @IBAction func viewPassword(_ sender: Any) {
        passwordBox.isSecureTextEntry.toggle()
    }
    
    @IBAction func usernameEditing(_ sender: Any) {
        passwordBox.isHidden = true
        viewPasswordButton.isHidden = true
        emailaddressBox.isHidden = true
        continueButton.setTitle("Continue", for: .normal)
    }
    
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func login(_ sender: Any) {
        usernameBox.resignFirstResponder()
        if passwordBox.isHidden{ // Initiate login or register
            if usernameBox.text == "test"{ // Enable login
                passwordBox.isHidden = false
                viewPasswordButton.isHidden = false
                continueButton.setTitle("Login", for: .normal)
            } else {
                passwordBox.isHidden = false
                viewPasswordButton.isHidden = false
                emailaddressBox.isHidden = false
                continueButton.setTitle("Register", for: .normal)
            }
            passwordBox.becomeFirstResponder()
            return
        } else if emailaddressBox.isHidden{ // Login
            if passwordBox.text == "error"{ // Enable login
                messageBox.text = "Invalid email"
                messageBox.textColor = UIColor.red
                return
            }
            
            // Set authToken
            UserDefaults.standard.set(usernameBox.text, forKey: "username")
        } else{ // Register
            UserDefaults.standard.set(usernameBox.text, forKey: "username")
        }
        
        // If error
        // messageBox.text = "Error text"
        
        // unwind
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.placeholder == "Password" && emailaddressBox.isHidden == false{
            print("Registering")
            emailaddressBox.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
            continueButton.sendActions(for: .touchUpInside)
        }

        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
