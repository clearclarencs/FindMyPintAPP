//
//  FeedViewController.swift
//  FindMyPint
//
//  Created by James Skipworth on 01/03/2024.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var posts = [
        ("Hopey344", "The cocktail selection was fantastic @Sphinx #Bargain"),
        ("GuinessLover82", "At the @brookhouse watching the Derby game, great game."),
        ("DawnB1945", "£7 rosé at @Flute #WineDrunk #Tipsy #Lads"),
        ("TheSphinx 🍺", "£2.20 Carling all week long, who could say no 🥵"),
        ("MrLeahy", "Rated @Hope&Anchor ★★★★✩"),
        ("EWilton69", "@Popworld WKD is lethal, had 2 last night blacked out and woke up in a police cell this morning. #FridayNights #WildOne #LGBT"),
        ("Hatch 🍺", "Free entry all night, blasting y2k club anthems. Roll on the weekend."),
        ("TheBlackCat 🍺", "Quiz night Wednesday‼️ £20 up for grabs but doors close 6pm."),
        ("Hopey344", "The cocktail selection was fantastic @Sphinx #Bargain"),
        ("GuinessLover82", "At the @brookhouse watching the Derby game, great game."),
        ("DawnB1945", "£7 rosé at @Flute #WineDrunk #Tipsy #Lads"),
        ("TheSphinx 🍺", "£2.20 Carling all week long, who could say no 🥵"),
        ("MrLeahy", "Rated @Hope&Anchor ★★★★✩"),
        ("EWilton69", "@Popworld WKD is lethal, had 2 last night blacked out and woke up in a police cell this morning. #FridayNights #WildOne #LGBT"),
        ("Hatch 🍺", "Free entry all night, blasting y2k club anthems. Roll on the weekend."),
        ("TheBlackCat 🍺", "Quiz night Wednesday‼️ £20 up for grabs but doors close 6pm."),
        ("Hopey344", "The cocktail selection was fantastic @Sphinx #Bargain"),
        ("GuinessLover82", "At the @brookhouse watching the Derby game, great game."),
        ("DawnB1945", "£7 rosé at @Flute #WineDrunk #Tipsy #Lads"),
        ("TheSphinx 🍺", "£2.20 Carling all week long, who could say no 🥵"),
        ("MrLeahy", "Rated @Hope&Anchor ★★★★✩"),
        ("EWilton69", "@Popworld WKD is lethal, had 2 last night blacked out and woke up in a police cell this morning. #FridayNights #WildOne #LGBT"),
        ("Hatch 🍺", "Free entry all night, blasting y2k club anthems. Roll on the weekend."),
        ("TheBlackCat 🍺", "Quiz night Wednesday‼️ £20 up for grabs but doors close 6pm."),

            
    ]
    let blueTheme = UIColor(red: 60.0/255.0, green: 133.0/255.0, blue: 168.0/255.0, alpha: 1.0)
    let yellowTheme = UIColor(red: 252.0/255.0, green: 165.0/255.0, blue: 3.0/255.0, alpha: 1.0)
    
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
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCell(withIdentifier: "aPost", for: indexPath)
        var content = UIListContentConfiguration.cell()
        content.attributedText = formatPost("@"+posts[indexPath.row].0, posts[indexPath.row].1)
//        content.secondaryText = posts[indexPath.row].1
        content.textProperties.font = UIFont.systemFont(ofSize: 20)
//        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 20)
        aCell.contentConfiguration = content
        
        return aCell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
