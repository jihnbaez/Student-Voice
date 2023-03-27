//
//  TableViewController.swift
//  Student Voice
//
//  Created by 4d on 2/3/23.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var suggestions:[Suggestion] = [Suggestion(name: "new food", detail: "We need more good food", upvotes:7, category: 0), Suggestion(name: "Extended Help", detail: "lengthen office hours", upvotes: 16, category: 1), Suggestion(name: "Tutoring", detail: "Allow students to professionally tutor (include hours)", upvotes: 21, category: 2)]
    var list:[Sections] = []
    
  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list[indexPath.section].suggestions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }   
    }
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
        tableView.reloadData()
        guard let source = segue.source as? SugeestionFormVC,
              let s = source.suggest
        else {return}
        
        let p = source.pickerView.selectedRow(inComponent: 0)
        print(p)
        
        
            if let indexPath = tableView.indexPathForSelectedRow {
                list[p].suggestions.remove(at: indexPath.row)
                list[p].suggestions[indexPath.row] = s

                list[p].suggestions.insert(s, at: indexPath.row)
                tableView.deselectRow(at: indexPath, animated: true)
               
                tableView.reloadRows(at: [indexPath], with: .none)

            }
            else{
//                list[0].suggestions.append(s)
               let newIndexPath = IndexPath(row: list[p].suggestions.count, section: 0)
                list[p].suggestions.append(s)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
               

            }
        tableView.reloadData()
        
    }

    @IBSegueAction func editBook(_ coder: NSCoder, sender: Any?) -> SugeestionFormVC? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            // Editing Emoji
            let emojiToEdit = list[indexPath.section].suggestions[indexPath.row]
            return SugeestionFormVC(coder: coder, list: emojiToEdit)
        } else {
            // Adding Emoji
            return SugeestionFormVC(coder: coder, list: nil)
        }
    }
    
//
//        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
//            return nil
//        }
//
//        let book = list[indexPath.section].suggestions[indexPath.row]
//
//        return SugeestionFormVC(coder: coder, list: book)
//    }
//

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       
    }
    func updateSections() {
        list.removeAll()

        let grouped = Dictionary(grouping: suggestions, by: { $0.sectionTitle })
        
        for (title, emojis) in grouped.sorted(by: { $0.0 < $1.0 }) {
            list.append(Sections(title: title, suggestions: emojis.sorted(by: { $0.name < $1.name })))
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return list.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return list[section].suggestions.count
        
        
    }

   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return "\(list[section].title)"
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "suggest", for: indexPath)
//        let category = list[indexPath.section]
//        let suggestion = category.suggestions[indexPath.row]
//        // Configure the cell...
//        cell.textLabel?.text = "\(suggestion.name)"
//        cell.detailTextLabel?.text = "\(suggestion.description)"
//        return cell
//
        let cell = tableView.dequeueReusableCell(withIdentifier: "suggest", for: indexPath) as! STableCellView
        let category = list[indexPath.section]
        let suggestion = category.suggestions[indexPath.row]
        
       cell.update(with: suggestion)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationItem.rightBarButtonItem?.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            tableView.deselectRow(at: indexPath, animated: true)
            self.navigationItem.rightBarButtonItem?.isHidden = false

            
        }
        
        
        let sectionToMoveTo = list[indexPath.section].suggestions[indexPath.row].category
        
                let newRowIndexPath = IndexPath(row: 0, section: sectionToMoveTo)
                
        let itemToMove = list[indexPath.section].suggestions[indexPath.row]
        list[indexPath.section].suggestions.remove(at: indexPath.row)
        list[sectionToMoveTo].suggestions.insert(itemToMove, at: 0)
                
                tableView.moveRow(at: indexPath, to: newRowIndexPath)
    }
    
    
    
  
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
       
        return true
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
