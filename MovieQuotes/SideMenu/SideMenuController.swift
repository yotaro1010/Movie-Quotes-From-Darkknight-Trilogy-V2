//
//  MenuTableViewController.swift
//  DemoV13
//
//  Created by Yotaro Ito on 2021/03/18.
//

import UIKit

class SideMenuController: UITableViewController{
    
    var delegate: SideMenuControllerDelegate?
    
    private let menuOptions: [SideMenuOption]
    
    init(with menuOptions: [SideMenuOption]) {
        self.menuOptions = menuOptions
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: SideMenuCell.identifier)
        tableView.backgroundColor = UIColor.black
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as! SideMenuCell

        cell.menuLabel.text = menuOptions[indexPath.row].rawValue
        cell.menuImageView.image = menuOptions[indexPath.row].menuImages

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMenuOption = menuOptions[indexPath.row].rawValue
        delegate?.didSelectMenuOption(option: SideMenuOption(rawValue: selectedMenuOption)!)
    }
   
    

}
