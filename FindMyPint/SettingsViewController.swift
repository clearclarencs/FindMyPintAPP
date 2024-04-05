//
//  SettingsViewController.swift
//  FindMyPint
//
//  Created by James Skipworth on 12/03/2024.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "username") // Remove use defaults
        // UserDefaults.standard.removeObject(forKey: "authToken")
        self.tabBarController?.selectedIndex = 0 // Go back to feed screen to trigger login
        
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
