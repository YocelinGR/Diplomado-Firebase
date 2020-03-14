//
//  WelcomeViewController.swift
//  TestFeedkit
//
//  Created by Yocelin D-5 on 07/03/20.
//  Copyright © 2020 Yocelin D-5. All rights reserved.
//

import UIKit
import Firebase


class WelcomeViewController: UIViewController {
/* cuando se cambia el controlador de la vista es necesario no solo cambiarla*/
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func signOut(_ sender: Any){
        var salida = try! Auth.auth().signOut()
        navigationController?.popViewController(animated: true)
    }
}
