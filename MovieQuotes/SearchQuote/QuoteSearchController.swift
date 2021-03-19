//
//  SampleVC.swift
//  DemoV13
//
//  Created by Yotaro Ito on 2021/03/11.
//

import Foundation
import UIKit

class QuoteSearchController: UIViewController, UISearchBarDelegate{
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(QuoteSearchCell.self, forCellReuseIdentifier: QuoteSearchCell.identifier)
        tableView.separatorColor = UIColor.white
        tableView.backgroundColor = UIColor.black
        return tableView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Quotes"
        searchBar.tintColor = UIColor.white
        searchBar.searchTextField.textColor = UIColor.white
        return searchBar
    }()
    
    let allQuotes: [Quotes] = {
        var allQuotes = [Quotes]()
        let quotes1 = Quotes.configureBeginsQuotes()
        let quotes2 = Quotes.configureDarkknightQuotes()
        let quotes3 = Quotes.configureRisesQuotes()
        allQuotes.append(contentsOf: quotes1)
        allQuotes.append(contentsOf: quotes2)
        allQuotes.append(contentsOf: quotes3)
        return allQuotes
    }()

    
    var resultQuotes = [Quotes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = true
        resultQuotes = allQuotes
    }
    
    func setUpNavigationItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.titleView = searchBar
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

            resultQuotes.removeAll()
        
            if searchText.isEmpty {
                resultQuotes = allQuotes
                
            } else {
                resultQuotes = allQuotes.filter {
                    
                    return  $0.quote.contains(searchText)
                    
                }
            }
        
            tableView.reloadData()
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
        }
}
    
extension QuoteSearchController: UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: QuoteSearchCell.identifier, for: indexPath) as! QuoteSearchCell
        cell.backgroundColor = UIColor.black
        let result = resultQuotes[indexPath.row]
        cell.configure(with: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
        let modalVC = testViewController()
        let position = indexPath.row
        modalVC.quotes = resultQuotes
        modalVC.position = position
        modalVC.modalPresentationStyle = .custom
        
        modalVC.transitioningDelegate = self
        present(modalVC, animated: true, completion: nil)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopUpController(presentedViewController: presented, presenting: presenting)
    }
}

