//
//  CollectionViewCell.swift
//  MovieBox
//
//  Created by Aslıhan Gürkan on 7.04.2023.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var images: UIImageView!
  
    public func configure(with model: String) {
           
       guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
           return
       }
        images.sd_setImage(with: url, completed: nil)
   }
}
