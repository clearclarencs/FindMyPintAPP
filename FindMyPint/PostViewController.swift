//
//  PostViewController.swift
//  FindMyPint
//
//  Created by James Skipworth on 05/03/2024.
//

import UIKit

class PostViewController: UIViewController, UITextViewDelegate {
    var createPost = false
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    
    @IBAction func createPost(_ sender: Any) {
        createPost = true
        performSegue(withIdentifier: "unwindFromPostSegue", sender: self)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
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
