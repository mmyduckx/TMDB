//
//  MovieCell.swift
//  MovieList
//
//  Created by xwx on 2/29/20.
//  Copyright © 2020 谢万祥. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieOverviewLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    func showStar(value:Int ) ->String{
        var star:String = ""
        if value < 20 && value >= 0{
            star = "★☆☆☆☆"
        }
        else if value < 50 {
            star = "★★☆☆☆"
        }
        else if value < 70 {
            star = "★★★☆☆"
        }
        else if value < 90 {
            star = "★★★★☆"
        }
        else if value <= 100{
            star = "★★★★★"
        }
        else {
            star = "TBD"
        }
        return star;
        
    }
    
    func setMovieInfo(movie: MovieInfo) {
            movieTitleLabel.text = movie.title
            ratingLabel.text = showStar(value: Int(movie.vote_average! * 10))
            movieOverviewLabel.text = movie.overview
            releaseDateLabel.text = movie.release_date
        
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")"){
            movieImageView.downloadedFrom(url: imageURL)
        }
        
        //       movieTitleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        //       movieTitleLabel.numberOfLines = 0
        //       movieOverviewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        //       movieOverviewLabel.numberOfLines = 0
        
    }
}

extension UIImageView {

func downloadedFrom(url: URL, contentMode mode:  UIView.ContentMode = .scaleAspectFit) {

    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else {
                return
                }
            DispatchQueue.main.async() {
                self.image = image
                
            }
        }.resume()
    }

}
