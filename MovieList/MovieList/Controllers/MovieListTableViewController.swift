//
//  MovieListTableViewController.swift
//  MovieList
//
//  Created by xwx on 2/26/20.
//  Copyright © 2020 谢万祥. All rights reserved.
//

import UIKit



class MovieListTableViewController: UITableViewController {
    var results: MovieResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            print("JSON download successful")
//            print(self.results?.numResults)
//            print(self.results?.movies.count)
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            self.tableView.reloadData()
        }
        
        navigationItem.title = "Popular Movies"
        
    }

    // MARK: - Table view data source
    
    func downloadJSON(completed: @escaping () -> () ) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=8520a5c87b0590da7b111e7d60071aba")

    URLSession.shared.dataTask(with: url!){ (data, response, err) in
        if err == nil {
            // check downloaded JSON data
            guard let jsondata = data else { return }

            do {
                self.results = try JSONDecoder().decode(MovieResults.self, from: jsondata)
                DispatchQueue.main.async {
                    completed()
                }
            }catch {
                print("JSON Downloading Error!") }
        }
    }.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        if let num_rows = results?.movies.count {
            return num_rows
        }else{
            return 20
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        if let movie = results?.movies[indexPath.row] {
            cell.setMovieInfo(movie: movie)
        }
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
        
            tableView.beginUpdates()
            results?.movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
//            print((results?.movies.count)!)
            
            
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let movie = results?.movies[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.movie = movie
            }
        }
    }
}


