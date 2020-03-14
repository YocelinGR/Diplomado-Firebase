//
//  ViewController.swift
//  TestFeedkit
//
//  Created by Yocelin D-5 on 06/03/20.
//  Copyright © 2020 Yocelin D-5. All rights reserved.
//

import UIKit
//import FeedKit
import Firebase
import FirebaseFirestore
/*let url = "https://www.npr.org/rss/podcast.php?id=500005"
 
 */

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var lastnameTF: UITextField!
    
    // Variables para el manejo de la base
    // ref: me ayuda hacer la conexion a la base de datos
    var ref: DocumentReference!
    // getRef: me permite acceder a la base de datos
    var getRef: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*guard let urlFeed = URL(string: url) else {
            print("no es vàlido")
            return
        }
        
        let parser = FeedParser(URL: urlFeed)
        parser.parseAsync{ (result) in
            switch result{
            case .success(let feed):
                let item = feed.rssFeed?.items?.first
                if let url = item?.enclosure?.attributes?.url{
                    print("Este es ek url: \(url)")
                } else {
                    return
                }
                break
            case .failure(let error):
                print(error)
            }
        }*/
        getRef = Firestore.firestore()
    }
    
    @IBAction func createUser(_ sender: UIButton){
        // uso de singleton de autenticacion sobre el framework de firebase con el metodo de auth
        guard let email = emailTF.text, email != "", let password = passwordTF.text, password != "", let name = nameTF.text, name != "", let lastname = lastnameTF.text, lastname != "" else {
            self.showMessage(message: "Falta algun dato")
            return
        }
        //Singgleton, auth es la parte estatica
        Auth.auth().createUser(withEmail: email, password: password) {(user, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            print("usuario creado", user?.user.uid)
            // HcVXodoAh4RsPOKJf43taO7I7Sb2
            self.storeUser(uid: (user?.user.uid)!, name: name, lastname: lastname)
        }
    }
    @IBAction func cancel(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    func showMessage(message: String){
        let alertController = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
    func storeUser(uid: String, name: String, lastname: String){
        var data: [String: Any] = ["name": name, "lastname": lastname]
        //Firebase.firestore().collection("items").documents("yourid").setData(documentData: , completion: )
        
        getRef.collection("users").document(uid).setData(data, completion: {(error) in
            if let error = error{
                self.showMessage(message: error.localizedDescription)
                return
            } else {
                print("Datos guardados")
            }
        })
        /*ref = getRef.collection("users").addDocument(data: data, completion: { (error) in
            if let error = error {
            self.showMessage(message: error.localizedDescription)
            return
        } else {
            print("Datos guardados")
            }
        })*/
    }
}

