//
//  ProfileViewController.swift
//  TestFeedkit
//
//  Created by Yocelin D-5 on 13/03/20.
//  Copyright © 2020 Yocelin D-5. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import MobileCoreServices
import FirebaseUI

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageLabel: UIImageView!
    
    
    var userID: String!
    var getRef: Firestore!
    var optimazedImage: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRef = Firestore.firestore()
        
        view.backgroundColor = .cyan
        // usar addStateDidChange o curentUser
        // patron observable
        Auth.auth().addStateDidChangeListener{ (auth, user) in
            if(user == nil){
                print("Usuario no loggeado")
            } else {
                self.userID = user?.uid
                self.emailLabel.text = user?.email
                self.getName()
                self.getPhoto()
            }
            
        }
    }
    func getPhoto(){
        let storageReference = Storage.storage().reference()
        // imagen por defecto
        let placeHolder = UIImage(named: "profile")
        // referencia a la imagen -> url
        let userImageRef = storageReference.child("/photos").child(self.userID)
        userImageRef.downloadURL { (url, error) in
            if let error = error {
                print(">>>>>>>", error.localizedDescription)
            } else {
                print("Imagen descargada")
            }
        }
        profileImageLabel.sd_setImage(with: userImageRef, placeholderImage: placeHolder)
    }
    func getName(){
        var result = getRef.collection("users").document(self.userID)
        // revisar patron observable
        result.getDocument{(snapshot, error) in
            print("Documente", snapshot?.documentID)
            // tipo de dato umbrella -> any
            let lastName = snapshot?.get("lastname") as? String ?? "Sin valor"
            print("lastname", lastName)
            let name = snapshot?.get("name") as? String ?? "Sin valor"
            self.nameLabel.text = "\(name) \(lastName)"
        }
    }
    @IBAction func uploadPhoto(_ sender: UIButton) {
       
        let photoImage = UIImagePickerController()
        // photoLibrary tambien puede ser la camara del telefono /ipad
        photoImage.sourceType = UIImagePickerController.SourceType.photoLibrary
        photoImage.mediaTypes = [kUTTypeImage as String]
        photoImage.delegate = self
        present(photoImage, animated: true)
        
    }
    // esta funcion solo sirve si tengo el photoImage.delegate = self en updloadPhoto
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let optimazedImageData = imageSelected.jpegData(compressionQuality: 0.6){
            profileImageLabel.image = imageSelected
            //optimazedImage = optimazedImageData
            self.saveImage(optimazedImageData)
            
        }
        dismiss(animated: true, completion: nil)
    }
    func saveImage(_ imageData: Data){
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        
        activityIndicator.color = .systemBlue
        activityIndicator.center = profileImageLabel.center
        activityIndicator.startAnimating()
        profileImageLabel.addSubview(activityIndicator)
        
        // conectate a la unidad de storage de firebase y da una referencia a este
        // conecta al buckted
        let storageReference = Storage.storage().reference()
        // crea carpetas y archivo
        // enlaza al archivo
        let userImageReference = storageReference.child("/photos").child(userID)
        // crea la metadata
        let uploadMetaData = StorageMetadata()
        // formato del archivo
        uploadMetaData.contentType = "image/jpeg"
        userImageReference.putData(imageData, metadata: uploadMetaData) {(storageMetadata, error) in
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            if let error = error{
                print("error", error.localizedDescription)
            } else {
                print(storageMetadata?.path)
            }
        }
        
    }
}
// los sistemas de almacenamiento se llaman buckets
