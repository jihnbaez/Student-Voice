
import UIKit

struct Suggestion {
    var title: String
    var details: String
    var votes: Int
}

class CustomAlertViewController: UIViewController, UITextFieldDelegate {

    var titleLabel: UILabel!
    var titleText:UITextField!
    var detailsLabel: UITextView!
    var sectionPicker: UIPickerView!
    var addButton: UIButton!
    var cancelButton: UIButton!
    var addHandler: ((_ title: String, _ details: String, _ selectedSection: Int) -> Void)?

    var sectionNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Create title label
//        titleLabel = UILabel(frame: CGRect(x: 20, y: 20, width: view.bounds.width - 40, height: 30))
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        titleLabel.textAlignment = .center
//        view.addSubview(titleLabel)
//
        
        
        titleText = UITextField(frame: CGRect(x: 20, y: 150, width: view.bounds.width - 40, height: 30))
        titleText.borderStyle = .line
        titleText.placeholder = "Enter Title"
        titleText.delegate = self
        view.addSubview(titleText)
        // Create details label
        detailsLabel = UITextView(frame: CGRect(x: 20, y: 200, width: view.bounds.width - 40, height: 100))
        detailsLabel.font = UIFont.systemFont(ofSize: 16)
        detailsLabel.textAlignment = .center
        detailsLabel.layer.borderWidth = 1

        view.addSubview(detailsLabel)

        // Create section picker
        sectionPicker = UIPickerView(frame: CGRect(x: 20, y: 300, width: view.bounds.width - 40, height: 100))
        sectionPicker.dataSource = self
        sectionPicker.delegate = self
        view.addSubview(sectionPicker)

        // Create add button
        addButton = UIButton(type: .system)
        addButton.frame = CGRect(x: 20, y: 450, width: 100, height: 30)
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)

        // Create cancel button
        cancelButton = UIButton(type: .system)
        cancelButton.frame = CGRect(x: view.bounds.width - 120, y: 450, width: 100, height: 30)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        view.addSubview(cancelButton)
    }

    @objc func addButtonTapped() {
        let selectedSection = sectionPicker.selectedRow(inComponent: 0)
        addHandler?(titleText.text ?? "", detailsLabel.text ?? "", selectedSection)
        dismiss(animated: true, completion: nil)
    }

    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension CustomAlertViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sectionNames.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sectionNames[row]
    }
}

class SuggestionsTable: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableData: [[Suggestion]] = [[Suggestion(title: "Museum", details: "Met Gala", votes: 6)], [Suggestion(title: "Volley Ball", details: "In school Competition ", votes: 6)]]
    var sectionNames: [String] = ["Field Trips", "In School Events"]
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a UITableView instance
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        // Create a button to add new suggestions
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSuggestion))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc func addSuggestion() {
        let alertController = CustomAlertViewController()
        alertController.modalPresentationStyle = .overFullScreen
        
        
        
        
        alertController.sectionNames = sectionNames
        alertController.addHandler = { [weak self] title, details, selectedSection in
            guard let self = self else { return }
            
            let newSuggestion = Suggestion(title: title, details: details, votes: 0)
            
            if selectedSection >= 0 && selectedSection < self.tableData.count {
                self.tableData[selectedSection].append(newSuggestion)
            } else {
                self.tableData.append([newSuggestion])
                self.sectionNames.append("Section \(self.tableData.count)")
            }
            
            self.tableView.reloadData()
        }
        
        
        
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - UITableViewDataSource methods

     func numberOfSections(in tableView: UITableView) -> Int {
         return tableData.count
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return tableData[section].count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       //  if cell == nil {
             cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        // }
        // let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         let suggestion = tableData[indexPath.section][indexPath.row]
         cell.textLabel?.text = "\(suggestion.title) - Votes: \(suggestion.votes)"
         cell.detailTextLabel?.text = suggestion.details
         return cell
     }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return sectionNames[section]
     }

     // MARK: - UITableViewDelegate methods

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)

         let suggestion = tableData[indexPath.section][indexPath.row]
         let alertController = UIAlertController(title: "Suggestion Details", message: suggestion.details, preferredStyle: .alert)

         let upvoteAction = UIAlertAction(title: "Upvote", style: .default) { (_) in
             self.upvoteSuggestion(at: indexPath)
         }
         
         let editAction = UIAlertAction(title: "Edit", style: .default) { (_) in
             self.editSuggestion(at: indexPath)
         }

         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

         alertController.addAction(upvoteAction)
         alertController.addAction(editAction)
         alertController.addAction(cancelAction)
         present(alertController, animated: true, completion: nil)
     }

     // MARK: - Helper methods

     func upvoteSuggestion(at indexPath: IndexPath) {
         tableData[indexPath.section][indexPath.row].votes += 1
         tableView.reloadData()
     }
     
     func editSuggestion(at indexPath: IndexPath) {
         let suggestion = tableData[indexPath.section][indexPath.row]
         let alertController = UIAlertController(title: "Edit Suggestion", message: nil, preferredStyle: .alert)
         
         alertController.addTextField { (textField) in
             textField.placeholder = "Enter title"
             textField.text = suggestion.title
         }
         
         alertController.addTextField { (textField) in
             textField.placeholder = "Enter details"
             textField.text = suggestion.details
         }
         
         let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
             if let title = alertController.textFields?.first?.text, let details = alertController.textFields?[1].text {
                 self.tableData[indexPath.section][indexPath.row].title = title
                 self.tableData[indexPath.section][indexPath.row].details = details
                 self.tableView.reloadData()
             }
         }
         
         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         
         alertController.addAction(saveAction)
         alertController.addAction(cancelAction)
         
         present(alertController, animated: true, completion: nil)
     }
 }

 extension SuggestionsTable: UIPickerViewDelegate, UIPickerViewDataSource {
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return sectionNames.count
     }
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return sectionNames[row]
     }
 }
