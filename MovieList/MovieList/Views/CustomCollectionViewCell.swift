//
//  CustomCollectionViewCell.swift
//  MovieList
//
//  Created by xwx on 3/8/20.
//  Copyright © 2020 谢万祥. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet var movieImageView: UIImageView!
    
    func setImage(path:String){
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)"){
            movieImageView.downloadedFrom(url: imageURL)
//            movieImageView.downloadedFrom(url: imageURL, contentMode: .scaleAspectFit)
        }
    }
    
}

