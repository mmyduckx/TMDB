//
//  DetailViewController.swift
//  MovieList
//
//  Created by xwx on 3/1/20.
//  Copyright © 2020 谢万祥. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var releasingDate: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var genreLabel: UILabel!
    
    
    var movie: MovieInfo? {
            didSet{
                let id = movie?.id
                let link = "https://api.themoviedb.org/3/movie/\(id!)?api_key=ed41fae537bf1c966f27986759d48c0e"
                let url = URL(string: link)
                URLSession.shared.dataTask(with: url!){ (data, response, err) in
                    if err == nil {
                        // check downloaded JSON data
                        guard let jsondata = data else { return }
                        do {
                            self.movieDetail = try JSONDecoder().decode(MoiveData.self, from: jsondata)
                            DispatchQueue.main.async {
                                self.setupViews()
                                self.collectionView.reloadData()
                            }
                        }catch {
                            print("JSON Downloading Error!")
                        }
                    }
                }.resume()
        }
    }
    
    var movieDetail: MoiveData?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        
//        print(movieDetail?.id)
        if(indexPath.row % 2 == 0){
             cell.setImage(path: (movieDetail?.backdrop_path ?? ""))
        }
        else{
            cell.setImage(path: (movieDetail?.poster_path ?? ""))
        }
       
        
        return cell
    }
    
    func setupViews(){
        navigationItem.title = movieDetail?.title
        titleLabel.text = movieDetail?.title
        ratingLabel.text = String((movieDetail?.vote_average!)!) + " " + showStar(value: Int((movieDetail?.vote_average!)! * 10))
        descriptionTextView.text = movieDetail?.overview
        releasingDate.text = movieDetail?.release_date
        
        let genres: [Genre] = movieDetail!.genres
        var showGenres: String = ""
        for genre in genres {
            showGenres.append(genre.name!)
            showGenres.append(" ")
        }
        
        genreLabel.text = showGenres
        
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
//        
//        genreLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
//        genreLabel.numberOfLines = 0
        
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(movieDetail?.poster_path ?? "")"){
            backgroundImageView.downloadedFrom(url: imageURL, contentMode: .scaleAspectFill)
        }
        
    }
    
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
        return star
        
    }
    

}
