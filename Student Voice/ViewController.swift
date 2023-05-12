//
//  ViewController.swift
//  Student Voice
//
//  Created by 4d on 4/17/23.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class ViewController:UIViewController
{
    
    @IBOutlet weak var emailTField:UITextField!
    @IBOutlet weak var psswrdTfield:UITextField!
    @IBOutlet weak var enter:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enter.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    @objc private func didTap()
    {
        guard let email = emailTField.text, !email.isEmpty, let password = psswrdTfield.text, !password.isEmpty else {
            print("Missing Field Data")
            return
    }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            print("You have signed in")

          strongSelf.emailTField.isHidden = true
          strongSelf.psswrdTfield.isHidden = true
          strongSelf.enter.isHidden = true
        })
    }
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default))
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                print("Account Creation failed")
                return
            }
            
            print("You have signed in")

            strongSelf.emailTField.isHidden = true
            strongSelf.psswrdTfield.isHidden = true
            strongSelf.enter.isHidden = true
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
