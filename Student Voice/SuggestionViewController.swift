//
//  SuggestionViewController.swift
//  Student Voice
//
//  Created by 4d on 3/10/23.
//

import UIKit

class SuggestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var list : Suggestion?
    
    @IBOutlet var suggestion: UITextView!
    @IBOutlet var titles: UITextField!
    @IBOutlet var category: UITextField!
    
    
    init?(coder: NSCoder, list:Suggestion?)
    {
        self.list = list
        super.init(coder:coder)
    }
    
    required init?(coder: NSCoder) {
        self.list = nil
        super.init(coder:coder)
    }
    
    func updateView (){
        guard let list = list else {
            return
        }
        suggestion.text = list.description
        titles.text = list.name
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard
              let title = titles.text, let suggestion = suggestion.text
        else {
            return
        }
        
        list = Suggestion(name: title, description: suggestion, upvotes: 0)
        performSegue(withIdentifier: "transfer", sender: self)
        
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
