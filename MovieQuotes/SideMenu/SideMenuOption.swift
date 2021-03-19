//
//  MenuOption.swift
//  DemoV13
//
//  Created by Yotaro Ito on 2021/03/18.
//
import UIKit
import Foundation

protocol SideMenuControllerDelegate {
    func didSelectMenuOption(option: SideMenuOption)
}

enum SideMenuOption: String, CaseIterable{

    case searchQuote = "Search Quotes"
    case searchMovie = "Search Movies"
    
    var menuImages: UIImage{
        switch self {
        case .searchQuote:
            return UIImage(systemName: "magnifyingglass") ?? UIImage()
        case .searchMovie:
            return UIImage(systemName: "star") ?? UIImage()
        }
    }
}
