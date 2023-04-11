//
//  SugeestionFormVC.swift
//  Student Voice
//
//  Created by 4d on 3/8/23.
//

import UIKit

class SuggestionFormViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var textView: UITextView!
    var suggest : Suggestion?
    
    @IBOutlet weak var saveButton: UIButton!
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
        pickerView.selectRow(suggest.category, inComponent: 0, animated: true)

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.selectRow(2, inComponent: 0, animated: true)

//        if let emoji = suggest {
//            textView.text = emoji.detail
//            titles.text = emoji.name
//                        title = "Edit Emoji"
//        } else {
//            title = "Add Emoji"
//        }
        
        updateSaveButtonState()
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
       
            suggest = Suggestion(name: title, detail:detail , upvotes: 0, category: pickerView.selectedRow(inComponent: 0))

            performSegue(withIdentifier: "transfer", sender: self)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickerView.selectRow(suggest?.category ?? 0, inComponent: 0, animated: true)
        // This will select the third row in the first component of the picker view
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func updateSaveButtonState() {
        let title = titles.text ?? ""
        let descriptionText =  textView.text ?? ""
        saveButton.isEnabled =  !title.isEmpty 
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

    let values = ["School Events", "Teachers", "Academics"]

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
        
        // MARK: - Table view data source
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "transfer" else { return }
//
//        let title = titles.text ?? ""
//        let details = textView.text ?? ""
//
//        suggest = Suggestion(name: title, detail: details, upvotes: suggest?.upvotes ?? 0, category: pickerView.selectedRow(inComponent: 0))
   // }
        
    
}
