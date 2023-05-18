//
//  ViewController.swift
//  Student Voice
//
//  Created by 8h on 1/5/23.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FeedPostableViewCell.self, forCellReuseIdentifier: FeedPostableViewCell.identifier)
        return tableView
    }()
        
    override func viewDidLoad() {
            super.viewDidLoad()
        view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            handleNotAuthenticated()
            
        }
        override func  viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tableView.frame = view.bounds
        }
        
        
        private func handleNotAuthenticated() {
            // Check auth status
            if Auth.auth().currentUser == nil {
                // Show log in
                
            }
        }
    }
    
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostableViewCell.identifier, for: indexPath)as!
            FeedPostableViewCell
        return cell
    }
}
