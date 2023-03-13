//
//  SugeestionFormVC.swift
//  Student Voice
//
//  Created by 4d on 3/8/23.
//

import UIKit

class SugeestionFormVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var textView: UITextView!
    var suggest : Suggestion?
    
    @IBOutlet weak var titles: UITextField!
    
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
        guard let suggest = suggest else {
            return
        }
        titles.text = suggest.name
        textView.text = suggest.detail
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        updateView()
        pickerView.delegate = self
              pickerView.dataSource = self
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard
            let title = titles.text, let detail = textView.text
        else {
            return
        }
        let picker = pickerView.selectedRow(inComponent: 0)
        
//        if (picker == 0)
//        {
            
            suggest = Suggestion(name: title, detail:detail , upvotes: 0)

//        }
//        else{
//            suggest = listOfSuggestions(title: values[1], suggestions: [Suggestion(name: "ss", description: "String", upvotes: 3)])

//        }
            performSegue(withIdentifier: "transfer", sender: self)
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    let values = ["School Events", "Teachers", "Academics"]

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
        
        // MARK: - Table view data source
        
        
    
}
