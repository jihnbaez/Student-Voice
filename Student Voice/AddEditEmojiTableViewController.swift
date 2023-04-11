import UIKit

class AddEditEmojiTableViewController: UITableViewController {
    
    var emoji: Emoji?

    @IBOutlet var symbolTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var usageTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    @IBOutlet weak var popUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopUpButton()

        if let emoji = emoji {
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.category
            title = "Edit Emoji"
        } else {
            title = "Add Emoji"
        }
        
        updateSaveButtonState()
    }
    
    init?(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupPopUpButton() {
        let popUpButtonClosure = { (action: UIAction) in
            print("Pop-up action")
        }
                
        popUpButton.menu = UIMenu(children: [
            UIAction(title: "First Entry", handler: popUpButtonClosure),
            UIAction(title: "Second Entry", handler: popUpButtonClosure)
        ])
        popUpButton.showsMenuAsPrimaryAction = true
    }
    func updateSaveButtonState() {
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    func containsSingleEmoji(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count == 1 else {
            return false
        }
        
        let isEmoji = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        
        return isEmoji
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }

        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        emoji = Emoji(name: name, category:usage, description: description)
    }
}
