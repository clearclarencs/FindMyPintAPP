//
//  FeedViewController.swift
//  FindMyPint
//
//  Created by James Skipworth on 01/03/2024.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var recommendedPosts = [
        ("Hopey344", "The cocktail selection was fantastic @Sphinx #Bargain"),
        ("GuinessLover82", "At the @brookhouse watching the Derby game, great game."),
        ("DawnB1945", "£7 rosé at @Flute #WineDrunk #Tipsy #Lads"),
        ("MrLeahy", "Rated @Hope&Anchor ★★★★✩"),
        ("EWilton69", "@Popworld WKD is lethal, had 2 last night blacked out and woke up in a police cell this morning. #FridayNights #WildOne #LGBT"),
        ("Hopey344", "The cocktail selection was fantastic @Sphinx #Bargain"),
        ("GuinessLover82", "At the @brookhouse watching the Derby game, great game."),
        ("DawnB1945", "£7 rosé at @Flute #WineDrunk #Tipsy #Lads"),
        ("MrLeahy", "Rated @Hope&Anchor ★★★★✩"),
        ("EWilton69", "@Popworld WKD is lethal, had 2 last night blacked out and woke up in a police cell this morning. #FridayNights #WildOne #LGBT"),
        ("Hopey344", "The cocktail selection was fantastic @Sphinx #Bargain"),
        ("GuinessLover82", "At the @brookhouse watching the Derby game, great game."),
        ("DawnB1945", "£7 rosé at @Flute #WineDrunk #Tipsy #Lads"),
        ("MrLeahy", "Rated @Hope&Anchor ★★★★✩"),
        ("EWilton69", "@Popworld WKD is lethal, had 2 last night blacked out and woke up in a police cell this morning. #FridayNights #WildOne #LGBT"),
    ]
    var friendsPosts = [
        ("GuinessLover82", "Just had my fifth guiness #AboutToShitMyself"),
        ("GuinessLover82", "At the @brookhouse watching the Derby game, great game."),
        ("GuinessLover82", "Never mind this shit buggy asf icl."),
        ("GuinessLover82", "This app is amazing its so well designed whoever made this is a legend."),
        ("GuinessLover82", "Just downloaded this, wtf even is this."),
    ]
    
    let blueTheme = UIColor(red: 60.0/255.0, green: 133.0/255.0, blue: 168.0/255.0, alpha: 1.0)
    let yellowTheme = UIColor(red: 252.0/255.0, green: 165.0/255.0, blue: 3.0/255.0, alpha: 1.0)
    
    var usernameClicked = ""
    
    @IBOutlet weak var feedType: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    func formatPost(_ author: String, _ comment: String) -> NSAttributedString {
        let text = author+"\n"+comment
        let authorRange = NSRange(location: 0, length: text.split(separator: "\n")[0].count+1)
        let attributedString = NSMutableAttributedString(string: text, attributes: [.foregroundColor: UIColor.label])
        
        let tagRegex = "(?:\\#[\\w&]+)|(?:\\@[\\w&]+)" // Regular expression to match #hashtags and @mentions
        
        do {
            let regex = try NSRegularExpression(pattern: tagRegex, options: [])
            let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
            
            for match in matches {
                attributedString.addAttribute(.foregroundColor, value: blueTheme, range: match.range)
            }
        } catch {
            print("Regex error: \(error)")
        }
        
        // Set author attributes
        attributedString.addAttribute(.foregroundColor, value: yellowTheme, range: authorRange)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: authorRange)
        
        return attributedString
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (feedType.selectedSegmentIndex == 0){  // Recommended feed
            return recommendedPosts.count
        } else {  // Friends feed
            return friendsPosts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCell(withIdentifier: "aPost", for: indexPath)
        var posts: [(String, String)]
        if (feedType.selectedSegmentIndex == 0){  // Recommended feed
            posts = recommendedPosts
        } else {  // Friends feed
            posts = friendsPosts
        }
        var content = UIListContentConfiguration.cell()
        content.attributedText = formatPost("@"+posts[indexPath.row].0, posts[indexPath.row].1)
        content.textProperties.font = UIFont.systemFont(ofSize: 20)
        aCell.contentConfiguration = content
        aCell.isUserInteractionEnabled = true
        
        return aCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (feedType.selectedSegmentIndex == 0){  // Recommended feed
            usernameClicked = recommendedPosts[indexPath.row].0
        } else {  // Friends feed
            usernameClicked = friendsPosts[indexPath.row].0
        }
        // If you want to perform a segue, you can do so here
        performSegue(withIdentifier: "viewProfileSegue", sender: self)
        
        // To deselect the cell after tapping
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    @IBAction func unwindFromPostSegue(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? PostViewController {
            if sourceViewController.createPost{
                friendsPosts.insert((UserDefaults.standard.string(forKey: "username")!, sourceViewController.postTextView.text), at: 0)
                friendsPosts.insert((UserDefaults.standard.string(forKey: "username")!, sourceViewController.postTextView.text), at: 0)
                tableView.reloadData()
            }
        }
    }

    
    @IBAction func changeFeedType(_ sender: Any) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewProfileSegue" {
            // Replace DestinationViewController with the class of your destination view controller
            if let destinationVC = segue.destination as? ProfileViewController {
                destinationVC.username = usernameClicked
                destinationVC.editable = false
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "username") == nil{
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
        tableView.reloadData()
    }

}
