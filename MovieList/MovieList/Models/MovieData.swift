//
//  MovieData.swift
//  MovieList
//
//  Created by xwx on 3/2/20.
//  Copyright © 2020 谢万祥. All rights reserved.
//

import Foundation

struct MovieInfo: Decodable {
    let id: Int?
    let poster_path: String?
    let title: String?
    let overview: String?
    let release_date: String?
    let vote_average: Double?
}


struct Genre: Decodable {
    let id: Int?
    let name: String?
}

struct MoiveData: Decodable {
    let id: Int?
    let title: String?
    let poster_path: String?
    let backdrop_path: String?
    let overview: String?
    let release_date: String?
    let status: String?
    let vote_average: Double?
    let genres: [Genre]
    
}

struct MovieResults: Decodable {
    let page: Int?
    let numResults: Int?
    let numPages: Int?
    var movies: [MovieInfo]
    

private enum CodingKeys: String, CodingKey {
    case page, numResults = "total_results", numPages = "total_pages", movies = "results" }

}
