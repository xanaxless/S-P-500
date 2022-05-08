//
//  ViewController.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 07.05.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - PROPERTIRES
    var isStockActive: Bool = true
    
    // MARK: - VIEW ELEMENTES
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .equalCentering
        stack.spacing = 5.0
        return stack
    }()
     
    var stockLabel: UITextView = {
        let textLabel = UITextView()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Stocks"
        textLabel.textAlignment = .center
        textLabel.font = UIFont.boldSystemFont(ofSize: 30)
        textLabel.textColor = .black
        textLabel.isEditable = false
        textLabel.isScrollEnabled = false
        return textLabel
    }()

    var favoriteLabel: UITextView = {
        let textLabel = UITextView()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Favourite"
        textLabel.textAlignment = .center
        textLabel.font = UIFont.boldSystemFont(ofSize: 20)
        textLabel.textColor = .systemGray
        textLabel.isEditable = false
        textLabel.isScrollEnabled = false
        return textLabel
    }()
    
    var stackforChoice: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .equalCentering
        stack.spacing = 16.0
        return stack
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        customChoiceStack()
        
        stockLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        stockLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        favoriteLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        favoriteLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(stackforChoice)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
       
    }
    
    private func customChoiceStack(){
        stackforChoice.addArrangedSubview(stockLabel)
        stackforChoice.addArrangedSubview(favoriteLabel)
    }


}

