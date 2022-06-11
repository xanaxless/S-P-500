//
//  DetailViewController.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 25.05.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var stock: Stock!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = .yellow
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "suit.heart.fill"), style: .plain, target: self, action: #selector(favoriteButtonTapped(_:)))
        navigationItem.rightBarButtonItem = favoriteButton
        title = stock.companyName
        view.backgroundColor = .white
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .systemGray
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationItem.searchController
        let standartApperance = UINavigationBarAppearance()
        standartApperance.backgroundColor = .red
        navigationController?.navigationBar.standardAppearance = standartApperance
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton!){
        
    }

    

}
