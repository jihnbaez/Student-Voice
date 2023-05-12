//
//  SettingsViewController.swift
//  Student Voice
//
//  Created by 6f on 5/4/23.
//

import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

/// View Controller to show user settings
final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = . systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func configureModels() {
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in

            },
            SettingCellModel(title: "Invite Friends") { [weak self] in

            },
            SettingCellModel(title: "Save Origianl Posts") { [weak self] in

            }
       ])
        
        
        
        data.append([
            SettingCellModel(title: "Terms of Service") { [weak self] in

            },
            SettingCellModel(title: "Privacy Policy") { [weak self] in

            },
            SettingCellModel(title: "Help / Feedback") { [weak self] in

            }
        ])
        
        data.append([
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
       ])
    }
    
    private func didTapLogOut() {
         
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}
