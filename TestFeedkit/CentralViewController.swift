//
//  CentralViewController.swift
//  TestFeedkit
//
//  Created by Yocelin D-5 on 13/03/20.
//  Copyright © 2020 Yocelin D-5. All rights reserved.
//

import UIKit

class CentralViewcontroller: UITabBarController{
    override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemPink
        tabBar.tintColor = .black
        // hago una instancia de la nueva clase que cree y pretendo usarla
        let ProfileController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController
        
        ProfileController!.tabBarItem.title = "Perfil"
        ProfileController!.tabBarItem.image = UIImage(systemName: "person.fill")
        let PhotosControllerTemp = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PhotoCollectionViewController") as? PhotoCollectionViewController)!
        
        let PhotosController = UINavigationController(rootViewController: PhotosControllerTemp)
        
        PhotosController.tabBarItem.title = "Fotos"
        PhotosController.tabBarItem.image = UIImage(systemName: "doc.richtext")
        let SaveController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FavoritesCollectionViewController") as? FavoritesCollectionViewController)!
        
        SaveController.tabBarItem.title = "Favoritos"
        SaveController.tabBarItem.image = UIImage(systemName: "tray.and.arrow.down.fill")
        // view controllers es una propiedad del tab bar y es una representacion de las vistas/controladores a los que se hara refernecia
        viewControllers = [
            ProfileController!,
            PhotosController,
            SaveController
        ]
    }
}

