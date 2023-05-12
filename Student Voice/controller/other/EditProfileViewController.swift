//
//  EditProfileViewController.swift
//  Student Voice
//
//  Created by 6f on 3/21/23.
//

import UIKit

class EditProfileViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    @objc private func didTapSave() {
        // Save info to database
    }
    
    
    @objc private func didTapCancel() {
       dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func didTapChangeProfielPicture() {
        let actionSheet = UIAlertController(title: "Profile Picutre", message: "Change Profile Picutre", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler:{ _ in
      
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Libary", style: .default, handler:{ _ in
       
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds

        present(actionSheet, animated: true)
        }
    }

