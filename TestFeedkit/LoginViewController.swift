//
//  LoginViewController.swift
//  TestFeedkit
//
//  Created by Yocelin D-5 on 07/03/20.
//  Copyright © 2020 Yocelin D-5. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func login(_ sender: UIButton){
        guard let email = emailTF.text, email != "", let password = passwordTF.text, password != "" else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else{
                print("Usuario autenticado")
                // segue programado
                // funciona si esta conectado: self.performSegue(withIdentifier: "welcomeView", sender: self)
                
                let welcomeView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WelcomeViewController") as? WelcomeViewController
                
                //aparece de abajo a arriba
                //self.present(welcomeView!, animated: true, completion: nil)
                self.navigationController?.pushViewController(welcomeView!, animated: true)
                self.dismiss(animated: true){
                    self.navigationController?.pushViewController(welcomeView!, animated: true)
                }
            }
        }
    }
    @IBAction func cancel(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }

}
