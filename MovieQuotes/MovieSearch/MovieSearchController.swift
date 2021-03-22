//
//  ViewController.swift
//  DemoV7
//
//  Created by Yotaro Ito on 2021/03/03.
//
import SafariServices
import UIKit

class MovieSearchController: UIViewController {

    let networker = NetworkManeger.shared
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Movies"
        searchBar.tintColor = UIColor.white
        searchBar.searchTextField.textColor = UIColor.white
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieSearchCell.self.self, forCellReuseIdentifier: "MovieSearchCell")
        tableView.backgroundColor = UIColor.black
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var listOfMovies = [Movie](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissSelf))
        navigationItem.titleView = searchBar
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        }
    
    
        @objc func dismissSelf(){
            dismiss(animated: true, completion: nil)
        }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func configureLayout(){
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
   
}

extension MovieSearchController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchCell.identifier, for: indexPath) as! MovieSearchCell
        cell.backgroundColor = UIColor.black
        
        let movie = listOfMovies[indexPath.row]
        
        cell.poster = nil
        
        cell.confugireUI(with: movie)
        
        networker.getImageData(movie: movie){data, error in
            if let data = data {
              let image = UIImage(data: data)
                DispatchQueue.main.async {
                    
                        cell.poster = image
                }
            }
        }

       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        let url = "https://www.themoviedb.org/movie/\(listOfMovies[indexPath.row].id ?? 0))"
         let VC = SFSafariViewController(url: URL(string: url)!)
        DispatchQueue.main.async {
            self.present(VC, animated: true)
        }
    }
}

extension MovieSearchController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()

        guard let text = searchBar.text, !text.isEmpty  else {
            return
        }
        
        networker.searchMovie(query: text, successHandler: {[weak self] (result) in
            self?.listOfMovies = result.movies
        }, errorHandler: {(error) in
            print(error)
        })
    }
      
    }



