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
//        画像frame幅の10%に設定
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
//        imageView.backgroundColor = .red
        return imageView
    }()
//
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name:"Copperplate", size: 18)
        label.backgroundColor = UIColor.black
        
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()

    private let characterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name:"Copperplate-Bold", size: 27)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
//
    private let characterLabelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")?.withTintColor(UIColor.darkGray)
//        imageView.layer.borderWidth = 1.0
//        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
//
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
//
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
//
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cardView)
        cardView.addSubview(quoteImageView)
        cardView.addSubview(button)
//        cardView.addSubview(characterLabelImage)
//        cardView.addSubview(characterLabel)
        cardView.addSubview(backButton)
//        cardView.addSubview(quoteLabel)
      
  
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
        quoteLabel.text = quote.quote
        characterLabel.text = quote.character
        quoteLabel.text = quote.quote
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
//        quoteImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor, multiplier: ).isActive = true
        quoteImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5).isActive = true
        quoteImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5).isActive = true

        quoteImageView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.6).isActive = true
//        quoteImageView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.6).isActive = true
        
        button.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: quoteImageView.bottomAnchor, constant: 5).isActive = true

        button.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5).isActive = true
        button.leadingAnchor.constraint(equalTo: quoteImageView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: quoteImageView.trailingAnchor).isActive = true
        
        
//        quoteLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
//        quoteLabel.topAnchor.constraint(equalTo: quoteImageView.bottomAnchor, constant: 5).isActive = true
//
//        quoteLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5).isActive = true
//        quoteLabel.leadingAnchor.constraint(equalTo: quoteImageView.leadingAnchor).isActive = true
//        quoteLabel.trailingAnchor.constraint(equalTo: quoteImageView.trailingAnchor).isActive = true
        
//        quoteLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.9).isActive = true

        
//        characterLabelImage.topAnchor.constraint(equalTo: quoteImageView.bottomAnchor, constant: 7).isActive = true
//        characterLabelImage.leadingAnchor.constraint(equalTo: quoteImageView.leadingAnchor).isActive = true
//        characterLabelImage.heightAnchor.constraint(equalTo: quoteImageView.heightAnchor, multiplier: 0.25).isActive = true
//        characterLabelImage.widthAnchor.constraint(equalTo: quoteImageView.widthAnchor).isActive = true
//
//        characterLabel.centerYAnchor.constraint(equalTo: characterLabelImage.centerYAnchor, constant: -9).isActive = true
//        characterLabel.leadingAnchor.constraint(equalTo: characterLabelImage.leadingAnchor).isActive = true
//        characterLabel.heightAnchor.constraint(equalTo: characterLabelImage.heightAnchor,multiplier: 0.5).isActive = true
//        characterLabel.widthAnchor.constraint(equalTo: characterLabelImage.widthAnchor).isActive = true
//
       
        
        
        backButton.topAnchor.constraint(equalTo: quoteImageView.topAnchor, constant: 5).isActive = true
        backButton.trailingAnchor.constraint(equalTo: quoteImageView.trailingAnchor, constant: -5).isActive = true
        backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor).isActive = true
        backButton.heightAnchor.constraint(equalTo: quoteImageView.heightAnchor, multiplier: 0.2).isActive = true
//        
//        buttonBackgroundImage.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 15).isActive = true
//        buttonBackgroundImage.heightAnchor.constraint(equalTo: quoteLabel.heightAnchor, multiplier: 0.4).isActive = true
//        buttonBackgroundImage.widthAnchor.constraint(equalTo: quoteLabel.widthAnchor, multiplier: 0.9).isActive = true
//        buttonBackgroundImage.centerXAnchor.constraint(equalTo: quoteLabel.centerXAnchor).isActive = true
        
//        button.topAnchor.constraint(equalTo: quoteImageView.centerYAnchor).isActive = true
//        button.leadingAnchor.constraint(equalTo: quoteImageView.trailingAnchor, constant: 20).isActive = true
//        button.trailingAnchor.constraint(equalTo: quoteLabel.trailingAnchor, constant: -20).isActive = true
//
//        button.widthAnchor.constraint(equalTo: quoteImageView.widthAnchor, multiplier: 0.2).isActive = true
//        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
//
//        button.topAnchor.constraint(equalTo: quoteImageView.centerYAnchor).isActive = true
//
//        button.widthAnchor.constraint(equalTo: buttonBackgroundImage.widthAnchor, multiplier: 0.3).isActive = true
//        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
    }
    
    @objc func didTapBack() {
        dismiss(animated: true, completion: nil)
    }

    @objc func didTapPlay(){
        let quote = quotes[position]
        if audioPlayer?.isPlaying == true {
            
            audioPlayer?.pause()
//            button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
            button.setTitle("Play", for: .normal)

        }
        else {
            
            audioPlayer?.play()
            button.setTitle(quote.quote, for: .normal)
     
            

//            button.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
            
//            UIView.animate(withDuration: 1, animations: {
//                
//                self.quoteImageView.frame = CGRect(x: self.quoteImageView.frame.size.height/2,
//                                                   y: self.quoteImageView.frame.size.width/2,
//                                                   width: (self.quoteImageView.frame.size.width)-20,
//                                                   height: (self.quoteImageView.frame.size.height)-20)
//                
//            })
        }
}

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        button.setTitle("Play", for: .normal)
    

//        button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let audioPlayer = audioPlayer {
            audioPlayer.stop()
        }
    }
}


