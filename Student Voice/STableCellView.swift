//
//  SuggestionTableViewCell.swift
//  Student Voice
//
//  Created by Lisette Antigua on 3/11/23.
//

import UIKit

class STableCellView: UITableViewCell {

    @IBOutlet weak var upVoteNumber: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var title: UILabel!
    var book:Suggestion!
    
    
var votes = 0
    var currentVote = 0
    
    func update(with book: Suggestion) {
        title.text = book.name
        details.text = book.detail
        currentVote = book.upvotes
        upVoteNumber.text = "Votes: " + String(currentVote)
        
        
    }


    @IBAction func upvoteButton(_ sender: UIButton) {
        currentVote += 1
        upVoteNumber.text = "Votes: "  +  String(currentVote)
        
    }
    
    @IBAction func downVoteButton(_ sender: UIButton) {
        
        if (currentVote > 0)
        {
            currentVote -= 1
            upVoteNumber.text = "Votes: "  +  String(currentVote)
        }
        
          

        
       

    }
    
    
}
