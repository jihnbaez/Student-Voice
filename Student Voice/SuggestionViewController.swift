//
//  SuggestionViewController.swift
//  Student Voice
//
//  Created by 4d on 3/10/23.
//

import UIKit

class SuggestionViewController: UIViewController {
    var suggest : Suggestion?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet var titles: UITextField!

    
    init?(coder: NSCoder, list:Suggestion?)
    {
        self.suggest = list
        super.init(coder:coder)
    }
    
    required init?(coder: NSCoder) {
        self.suggest = nil
        super.init(coder:coder)
    }
    
    func updateView (){
        guard let list = suggest else {
            return
        }
        titles.text = list.name
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard
              let title = titles.text
        else {
            return
        }
        

        
        suggest = Suggestion(name: "test", detail: title, upvotes: 0)

        performSegue(withIdentifier:"transfer", sender: self)
        
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
