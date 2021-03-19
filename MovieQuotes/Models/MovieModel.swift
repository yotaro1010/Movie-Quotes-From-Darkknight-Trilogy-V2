//
//  Model.swift
//  DemoV7
//
//  Created by Yotaro Ito on 2021/03/03.
//

import Foundation

struct MovieResponse: Decodable{
    
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey{
        case movies = "results"
    }
}
    struct Movie: Decodable {
        let title: String?
        let year: String?
        let rate: Double?
        let posterImage: String?
        let overView: String?
        let language: String?
        let id: Int?
        
        var posterURL: URL {
                return URL(string: "https://image.tmdb.org/t/p/w500\(posterImage ?? "")")!
            }
        
        private enum CodingKeys: String,CodingKey{
            case title
            case year = "release_date"
            case rate = "vote_average"
            case posterImage = "poster_path"
            case overView = "overview"
            case language = "original_language"
            case id 
        }
    }

public enum MovieError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
