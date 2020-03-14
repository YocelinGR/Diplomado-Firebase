//
//  DetailPhotoViewController.swift
//  TestFeedkit
//
//  Created by Yocelin D-5 on 14/03/20.
//  Copyright © 2020 Yocelin D-5. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class DetailPhotoViewController: UIViewController {
    var userID: String!
    var getRef: Firestore!
    //var width: Int!
    var imagen: UIImage! = nil
    let photoView: UIImageView = {
        let pv = UIImageView(frame: CGRect(x: 8, y: 16, width: 300, height: 300))
        return pv
    }()
    let saveButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Descargar imagen", for: .normal)
        // se habilita de forma programatica los constraints
        b.translatesAutoresizingMaskIntoConstraints = false
        // ib action
        b.addTarget(self, action: #selector(savePhoto), for: .touchUpInside)
        return b
    }()
    let favoritesButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Agregar a favoritos", for: .normal)
        // se habilita de forma programatica los constraints
        b.translatesAutoresizingMaskIntoConstraints = false
        // ib action
        b.addTarget(self, action: #selector(addPhotoToFavorites), for: .touchUpInside)
        return b
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        photoView.image = imagen
        view.addSubview(photoView)
        view.addSubview(saveButton)
        view.addSubview(favoritesButton)
        photoView.center = view.center
        // width = view.frame.maxX - 16
        saveButton.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 10).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        favoritesButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10).isActive = true
        favoritesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    @objc func savePhoto(){
        // obtenemos la imagen
        guard let imagen = photoView.image else { return }
        
        // pedir permisos de acceso al usuario, ya que ingresa a local
        // params: imagen, que va a pasar cuando se termine de guardar, ,
        UIImageWriteToSavedPhotosAlbum(imagen, nil, #selector(saveImg(_:didFinishSavingWithErro:contextInfo:)), nil)
    }
    
    @objc func saveImg(_ image: UIImage, didFinishSavingWithErro error: Error?, contextInfo: UnsafeRawPointer){
        print("guardado")
    }
    
    @objc func addPhotoToFavorites(){
        // obtenemos la imagen
        print("Add to favorites")
        guard let imagen = photoView.image else { return }
        
        let storageReference = Storage.storage().reference()
        // crea carpetas y archivo
        // enlaza al archivo
        let userImageReference = storageReference.child("/favorites").child("\(self.userID)")
        // crea la metadata
        let uploadMetaData = StorageMetadata()
        // formato del archivo
        uploadMetaData.contentType = "image/jpeg"
        userImageReference.putData(imagen, metadata: uploadMetaData) {(storageMetadata, error) in
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            if let error = error{
                print("error", error.localizedDescription)
            } else {
                print(storageMetadata?.path)
            }
    }
}
//NSPhoto
