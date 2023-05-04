//
//  Home.swift
//  Student Voice
//
//  Created by 4d on 5/2/23.
//

import UIKit
import Firebase
import FirebaseAuth

class Home: UIViewController {

    @IBOutlet var signOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if FirebaseAuth.Auth.auth().currentUser != nil {
            signOut.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
            
        }
        
    }
    
    @objc private func signOutTapped () {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            performSegue(withIdentifier: "signout", sender: nil)

        }
        catch {
            print("An error has occured")
        }
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
