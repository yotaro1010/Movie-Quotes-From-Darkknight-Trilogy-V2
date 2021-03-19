//
//  APIManeger.swift
//  DemoV7
//
//  Created by Yotaro Ito on 2021/03/03.
//

import Foundation

public class NetworkManeger {
    
    static var shared = NetworkManeger()
    
   
    private let apiKey = "268b9dd32048232e65d0ffd16ef6dd65"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private var dataTask: URLSessionDataTask?
    
    private var imageUrlString: String = ""
    private var cacheimages = NSCache<NSString, NSData>()

    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        guard var urlComponents = URLComponents(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(MovieError.invalidEndpoint))
            print("invalid URL")
            return
        }
        
        urlComponents.queryItems =
            [URLQueryItem(name: "api_key", value: apiKey),
             URLQueryItem(name: "language", value: "en-US"),
             URLQueryItem(name: "include_adult", value: "false"),
             URLQueryItem(name: "region", value: "US"),
             URLQueryItem(name: "query", value: query),
            ]
        
        guard let url = urlComponents.url else {
//            errorHandler(MovieError.invalidEndpoint)
            completion(.failure(MovieError.invalidEndpoint))
            print("invalid URL")

            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {

                completion(.failure(MovieError.apiError))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            completion(.failure(MovieError.invalidResponse))
         
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                completion(.failure(MovieError.noData))
                print("No data")

                return
            }
            
            do {
                let moviesResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {

                    completion(.success(moviesResponse))
                }
            } catch {

                completion(.failure(MovieError.serializationError))
                print("Json error")
           }
        }
        dataTask?.resume()
        
    }
            
  private func cachingImages(imageURL: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        if let imageData = cacheimages.object(forKey: imageURL.absoluteString as NSString){
            print("using cach images")
            completion(imageData as Data, nil)
            return
        }

        let task = URLSession.shared.downloadTask(with: imageURL) { localUrl, response, error in
         if let error = error {
           completion(nil, error)
           return
         }

         guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
               completion(nil, NetworkManagerError.badResponse(response))
           return
         }

         guard let localUrl = localUrl else {
               completion(nil, NetworkManagerError.badLocalUrl)
           return
         }

         do {
           let data = try Data(contentsOf: localUrl)

            self.cacheimages.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
            completion(data,nil)

         } catch let error {
           completion(nil, error)
         }
       }

       task.resume()
     }
    
    func getImageData(movie: Movie, completion: @escaping (Data?, Error?) -> (Void)) {
        
        guard let posterString = movie.posterImage else {return}
        imageUrlString = "https://image.tmdb.org/t/p/w500" + posterString
        
        let url = URL(string: imageUrlString)!
        cachingImages(imageURL: url, completion: completion)
    }
}
