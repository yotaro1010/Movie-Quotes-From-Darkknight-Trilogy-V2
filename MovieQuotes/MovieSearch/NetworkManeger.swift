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

    private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
           DispatchQueue.main.async {
               errorHandler(error)
           }
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

extension NetworkManeger: NetworkManegerProtocol{
    
    func searchMovie(query: String, successHandler: @escaping (MovieResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard var urlComponents = URLComponents(string: "\(baseAPIURL)/search/movie") else {
            
            errorHandler(MovieError.invalidEndpoint)
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
            errorHandler(MovieError.invalidEndpoint)
            
            print("invalid URL")

            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if  error != nil  {
                self.handleError(errorHandler: errorHandler, error: MovieError.apiError)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                self.handleError(errorHandler: errorHandler, error: MovieError.invalidResponse)
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: MovieError.noData)
                return
            }
            
            do {
                let moviesResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    successHandler(moviesResponse)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
           }
        }
        dataTask?.resume()
    }
}
