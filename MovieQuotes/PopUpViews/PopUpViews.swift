//
//  Tes1View.swift
//  DemoV11
//
//  Created by Yotaro Ito on 2021/03/10.
//

import Foundation

import  AVFoundation
import UIKit

class testViewController: UIViewController,AVAudioPlayerDelegate{

    public var position: Int  = 0
    public var quotes: [Quotes] = []
    
   private var audioPlayer: AVAudioPlayer?

    private let cardView:UIView = {
        let card = UIView()
        card.backgroundColor = UIColor.gray
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()

    private let quoteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.sizeToFit()
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()

    private let buttonBackgroundImage : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cardView)
        cardView.addSubview(quoteImageView)
        cardView.addSubview(backButton)
        cardView.addSubview(button)
    }
    
    @objc func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
        configureCard()
    }
   
    func configureCard(){
        
        let quote = quotes[position]
        
        quoteImageView.image = UIImage(named: quote.imageName)
        backButton.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        button.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        
        
       
                let urlString = Bundle.main.path(forResource: quote.quoteMp3name ,ofType: "mp3")
        
                do {
                    try AVAudioSession.sharedInstance().setMode(.default)
                    try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                    guard let urlString = urlString else {
                        return
                    }
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                    audioPlayer?.delegate = self
                } catch  {
                    print("Error")
                }
    }

    func configureLayout(){
        
        cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        quoteImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 5).isActive = true
        quoteImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5).isActive = true
        quoteImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5).isActive = true
        quoteImageView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.6).isActive = true
        
        button.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: quoteImageView.bottomAnchor, constant: 5).isActive = true
        button.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5).isActive = true
        button.leadingAnchor.constraint(equalTo: quoteImageView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: quoteImageView.trailingAnchor).isActive = true
        
        backButton.topAnchor.constraint(equalTo: quoteImageView.topAnchor, constant: 5).isActive = true
        backButton.trailingAnchor.constraint(equalTo: quoteImageView.trailingAnchor, constant: -5).isActive = true
        backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor).isActive = true
        backButton.heightAnchor.constraint(equalTo: quoteImageView.heightAnchor, multiplier: 0.2).isActive = true

    }
    
    @objc func didTapBack() {
        dismiss(animated: true, completion: nil)
    }

    @objc func didTapPlay(){
        let quote = quotes[position]
        if audioPlayer?.isPlaying == true {
            
            audioPlayer?.pause()
            button.setTitle("Play", for: .normal)

        }
        else {
            
            audioPlayer?.play()
            button.setTitle(quote.quote, for: .normal)

        }
}

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        button.setTitle("Play", for: .normal)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let audioPlayer = audioPlayer {
            audioPlayer.stop()
        }
    }
}


