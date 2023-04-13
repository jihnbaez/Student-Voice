//
//  TableViewController.swift
//  Student Voice
//
//  Created by 4d on 2/3/23.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var events:[Suggestion] = [Suggestion(name: "new food", detail: "We need more good food", upvotes:7, category: 0)]
    var teachers:[Suggestion] =  [Suggestion(name: "Extended Help", detail: "lengthen office hours", upvotes: 16, category: 1)]
    var academics:[Suggestion] = [Suggestion(name: "Tutoring", detail: "Allow students to professionally tutor (include hours)", upvotes: 21, category: 2)]
    var list:[listOfSuggestions]!
    
  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list[indexPath.section].suggestions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        guard let source = segue.source as? SuggestionFormViewController,
              let s = source.suggest
        else {return}
        
        let p = source.pickerView.selectedRow(inComponent: 0)
        print(p)
        
        if(p == 0){
            if let indexPath = tableView.indexPathForSelectedRow {
                
                list[0].suggestions.remove(at: indexPath.row)
                list[0].suggestions.insert(s, at: indexPath.row)
                tableView.deselectRow(at: indexPath, animated: true)
                
                
            }
            else{
                list[0].suggestions.append(s)
            }
        }
        
        if(p == 1){
            if let indexPath = tableView.indexPathForSelectedRow {
                
                list[1].suggestions.remove(at: indexPath.row)
                list[1].suggestions.insert(s, at: indexPath.row)
                tableView.deselectRow(at: indexPath, animated: true)
                
                
            }
            else{
                list[1].suggestions.append(s)
            }
        }
        if(p == 2){
            if let indexPath = tableView.indexPathForSelectedRow {
                
                list[2].suggestions.remove(at: indexPath.row)
                list[2].suggestions.insert(s, at: indexPath.row)
                tableView.deselectRow(at: indexPath, animated: true)
                
                
            }
            else{
                list[2].suggestions.append(s)
            }
        }
    }

    @IBSegueAction func editBook(_ coder: NSCoder, sender: Any?) -> SuggestionFormViewController? {
        
        guard let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) else {
            return nil
        }
        
        let book = list[indexPath.section].suggestions[indexPath.row]
        
        return SuggestionFormViewController(coder: coder, list: book)
    }
                              

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = [listOfSuggestions(title: "School Events", suggestions: events),
       listOfSuggestions(title: "Teachers", suggestions:teachers), listOfSuggestions(title: "Academics", suggestions:academics)]

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
