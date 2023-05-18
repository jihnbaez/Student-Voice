//
//  LogIn.swift
//  Student Voice
//
//  Created by 4d on 4/27/23.
//

import UIKit
import Firebase
import FirebaseAuth

class LogIn: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
            
            // Get the user's email and password
            guard let email = emailTextField.text, let password = passwordTextField.text else {
                return
            }
            
            // Sign in with Firebase
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    // Successful login
                    print("Login successful!")
                    self.performSegue(withIdentifier: "login", sender: nil)
                } else {
                    // Login error
                    print("Login error: \(error!.localizedDescription)")
                }
            }
        }
        
        // Connect UI elements to code
        
    }
    // Connect UI elements to code







    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


