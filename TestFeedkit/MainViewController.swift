//
//  MainViewController.swift
//  TestFeedkit
//
//  Created by Yocelin D-5 on 07/03/20.
//  Copyright © 2020 Yocelin D-5. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        isLogged()
    }
    func isLogged(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil{
                print("User no loggeado")
                return
            } else {
                print("Usuario no loggeado")
                self.performSegue(withIdentifier: "welcomeView", sender: self)
            }
        }
    }
}
