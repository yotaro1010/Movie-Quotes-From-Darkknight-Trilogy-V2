//
//  File.swift
//  DemoV11
//
//  Created by Yotaro Ito on 2021/03/11.
//
import SideMenu
import Foundation
import UIKit

class HomeViewController: UIViewController{
    
    private var sideMenu: SideMenuNavigationController?
    
    let quote1 = Quotes.configureBeginsQuotes()
    let quote2 = Quotes.configureDarkknightQuotes()
    let quote3 = Quotes.configureRisesQuotes()
  
   var movieSection = [String]()
   var allQuotes = [[Quotes]]()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HomeViewController.createLayout())
        collectionView.backgroundColor = UIColor.black
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        return collectionView
    }()
    
    let headerId = "headerId"
    static let HomeHeaderId = "HomeHeaderId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = SideMenuController(with: SideMenuOption.allCases)
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        menu.delegate = self
        
        view.addSubview(collectionView)
        collectionView.register(HomeHeader.self,
                                forSupplementaryViewOfKind: HomeViewController.HomeHeaderId,
                                withReuseIdentifier: headerId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setUpNavigationBar()
        configureQuotes()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func setUpNavigationBar(){
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3"),
            style: .plain,
            target: self,
            action: #selector(didTapMenu))
    }
    
    @objc func didTapMenu(){
        present(sideMenu!, animated: true)
    }
    
    func configureQuotes(){
        movieSection = [
            "Batman Begins",
            "Dark Knight",
            "Dark Knight Rises"
        ]
        for _ in 0...2 {
            allQuotes.append([])
        }
        allQuotes[0] = quote1
        allQuotes[1] = quote2
        allQuotes[2] = quote3
    }

    static func createLayout() -> UICollectionViewCompositionalLayout{
        return UICollectionViewCompositionalLayout{ (sectionNunber, env) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .fractionalHeight(1)))
            item.contentInsets.trailing = 30
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(250),
                                                                             heightDimension: .absolute(300)),
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30)
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(80)),
                      elementKind: HomeHeaderId,
                      alignment: .topLeading)
            ]
            return section
        }
    }
}

extension HomeViewController: SideMenuControllerDelegate{
    func didSelectMenuOption(option: SideMenuOption) {
        sideMenu?.dismiss(animated: true, completion: {[weak self] in
            
            switch option{
            
            case .searchQuote:
                let vc = QuoteSearchController()
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true, completion: nil)

            case .searchMovie:
                let vc = MovieSearchController()
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true, completion: nil)
            }
        })
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerTransitioningDelegate{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId , for: indexPath) as! HomeHeader
        header.headerLabel.text = movieSection[indexPath.section]
        
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return movieSection.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allQuotes[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        
        let quotes = allQuotes[indexPath.section][indexPath.row]
              cell.configure(with: quotes)
                  return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let modalVC = testViewController()
        let position = indexPath.row
        modalVC.quotes = allQuotes[indexPath.section]
        modalVC.position = position
        modalVC.modalPresentationStyle = .custom
        
        modalVC.transitioningDelegate = self
        present(modalVC, animated: true, completion: nil)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return testPopUpController(presentedViewController: presented, presenting: presenting)
    }
}

































    
