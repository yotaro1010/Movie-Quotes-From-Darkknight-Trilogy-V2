//
//  MovieTableViewCell.swift
//  DemoV7
//
//  Created by Yotaro Ito on 2021/03/05.
//

import UIKit

class MovieSearchCell: UITableViewCell {

    static let identifier = "MovieSearchCell"
    
    private let containerView: UIView = {
        let uiview = UIView()
        uiview.translatesAutoresizingMaskIntoConstraints = false
        uiview.layer.borderWidth = 1.5
        uiview.layer.borderColor = UIColor.systemBlue.cgColor
        uiview.backgroundColor = UIColor.black
        return uiview
    }()
    
    private let moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        return imageView
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private let movieLanguage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.systemBlue.cgColor
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor.systemBlue
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()

    private let movieYear: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.systemBlue.cgColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.systemBlue
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private let movieRate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.systemYellow.cgColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.systemYellow
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()

    private let movieOverView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func confugireUI(with model: Movie){
        configureCellLayout()
       
        movieTitle.text = model.title
        
        guard let year = model.year else {return}
        movieYear.text = "Release: \(year)"
        
        guard let language = model.language else {return}
        movieLanguage.text = "Language: \(language)"
        
        guard let overview = model.overView else {
            return movieOverView.text = "No Plot Found"
        }
        movieOverView.text = overview
        
        guard let rate = model.rate else {return}
        movieRate.text = "User Score: \(rate)/10"

        
        self.moviePoster.image = nil
    }
    
    var poster: UIImage? {
      didSet {
        moviePoster.image = poster
      }
    }
    
   func configureCellLayout(){
    contentView.addSubview(containerView)
    containerView.addSubview(moviePoster)
    containerView.addSubview(movieTitle)
    containerView.addSubview(movieYear)
    containerView.addSubview(movieRate)
    containerView.addSubview(movieLanguage)
    containerView.addSubview(movieOverView)

    containerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
    containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
    containerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
    containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true

    moviePoster.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
    moviePoster.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
    moviePoster.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.6).isActive = true
    moviePoster.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5).isActive = true

    movieTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5).isActive = true
    movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 5).isActive = true
    movieTitle.topAnchor.constraint(equalTo: moviePoster.topAnchor).isActive = true
    movieTitle.heightAnchor.constraint(equalTo: moviePoster.heightAnchor, multiplier: 0.3).isActive = true
    
    movieRate.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor).isActive = true
    movieRate.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor).isActive = true
    movieRate.heightAnchor.constraint(equalTo: movieTitle.heightAnchor).isActive = true
    movieRate.bottomAnchor.constraint(equalTo: moviePoster.bottomAnchor).isActive = true
    
    movieLanguage.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor).isActive = true
    movieLanguage.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor).isActive = true
    movieLanguage.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5).isActive = true
    movieLanguage.bottomAnchor.constraint(equalTo: moviePoster.centerYAnchor, constant: -2.5).isActive = true
    
    movieYear.trailingAnchor.constraint(equalTo: movieLanguage.trailingAnchor).isActive = true
    movieYear.leadingAnchor.constraint(equalTo: movieLanguage.leadingAnchor).isActive = true
    movieYear.topAnchor.constraint(equalTo: moviePoster.centerYAnchor, constant: 2.5).isActive = true
    movieYear.bottomAnchor.constraint(equalTo: movieRate.topAnchor, constant: -5).isActive = true

    movieOverView.leadingAnchor.constraint(equalTo: moviePoster.leadingAnchor).isActive = true
    movieOverView.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor).isActive = true
    movieOverView.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 5).isActive = true
    movieOverView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
    
    }
}

