//
//  PhotoCollectionViewCell.swift
//  TestFeedkit
//
//  Created by Yocelin D-5 on 14/03/20.
//  Copyright © 2020 Yocelin D-5. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var photoView: UIImageView = {
        // Declafra propiedad photo view
        let pv = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return pv
    }()
    // Metodos constructores para mediar la reinion 
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Printando")
        addSubview(photoView)
    }
    required init?(coder: NSCoder){
        super.init(coder:coder)
    }
}
