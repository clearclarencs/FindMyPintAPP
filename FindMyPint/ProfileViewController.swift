//
//  ProfileViewController.swift
//  FindMyPint
//
//  Created by James Skipworth on 04/03/2024.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource {
    
    let icons = ["Corona", "Amstel", "Budweiser", "Stella"]

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var firstPintButton: UIButton!
    @IBOutlet weak var secondPintButton: UIButton!
    @IBOutlet weak var thirdPintButton: UIButton!
    @IBOutlet weak var firstPubButton: UIButton!
    @IBOutlet weak var secondPubButton: UIButton!
    @IBOutlet weak var thirdPubButton: UIButton!
    @IBOutlet weak var reviewTable: UITableView!
    
    @IBAction func firstPubClicked(_ sender: Any) {
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "1st pub", message: "Pub name", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Name"
        }

        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            self.firstPubButton.configuration?.subtitle = alertController.textFields![0].text
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
    @IBAction func secondPubClicked(_ sender: Any) {
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "2nd pub", message: "Pub name", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Name"
        }

        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            self.secondPubButton.configuration?.subtitle = alertController.textFields![0].text
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
    @IBAction func thirdPubClicked(_ sender: Any) {
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "3rd pub", message: "Pub name", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Name"
        }

        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            self.thirdPubButton.configuration?.subtitle = alertController.textFields![0].text
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func firstPintClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Select a beer", message: "Choose your favourite beer", preferredStyle: .actionSheet)

        for icon in icons {
            let action = UIAlertAction(title: icon, style: .default) { action in
                self.firstPintButton.setImage(UIImage(named: icon), for: .normal)
            }
            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func secondPintClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Select a beer", message: "Choose your second favourite beer", preferredStyle: .actionSheet)

        for icon in icons {
            let action = UIAlertAction(title: icon, style: .default) { action in
                self.secondPintButton.setImage(UIImage(named: icon), for: .normal)
            }
            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func thirdPintClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Select a beer", message: "Choose your third favourite beer", preferredStyle: .actionSheet)

        for icon in icons {
            let action = UIAlertAction(title: icon, style: .default) { action in
                self.thirdPintButton.setImage(UIImage(named: icon), for: .normal)
            }
            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reviews = ["★★★★★ The Brookhouse", "★☆☆☆☆ Willowbank", "★★★★☆ Sphinx"]
        let aCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        var content = UIListContentConfiguration.cell()
        content.text = reviews[indexPath.row]
        aCell.contentConfiguration = content
        
        return aCell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        usernameLabel.text = UserDefaults.standard.string(forKey: "username") ?? "Unknown"
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
