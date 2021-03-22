//
//  NetworkManegerProtocol.swift
//  MovieQuotes
//
//  Created by Yotaro Ito on 2021/03/22.
//


protocol NetworkManegerProtocol {
    func searchMovie(query: String, successHandler: @escaping (MovieResponse) -> Void, errorHandler: @escaping (Error) -> Void)
}
