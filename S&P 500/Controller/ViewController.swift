//
//  ViewController.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 07.05.2022.
//

import UIKit

class ViewController: UIViewController 
{
    let base : [String] = [ "AAPL" , "YNDX", "GOOGL" , "AMZN" , "BAC", "MSFT" , "TSLA" , "MA"]
    // MARK: - ViewModels
    let stockPriceViewModel = StockPriceViewModel()
    
    // MARK: - PROPERTIRES
    var isStockActive: Bool = true
    var stockList: [StockPrice] = [StockPrice]()
    
    // MARK: - VIEW ELEMENTES
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .equalSpacing
        stack.spacing = 5.0
        stack.layer.cornerRadius = 20
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
    
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor.systemGray
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stockPriceViewModel.parseData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        stockPriceViewModel.delegate = self
        setUpView()
        tableView.reloadData()
    }
    
    private func setUpView(){
        view.backgroundColor = .white
        
        
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(stackforChoice)
        stackView.addArrangedSubview(tableView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
        customChoiceStack()
        
        stockLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        stockLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        favoriteLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        favoriteLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        tableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tableView.topAnchor.constraint(equalTo: stackforChoice.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
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

// MARK: -
extension ViewController: StockPriceDelegate{
    func update() {
        stockList = stockPriceViewModel.stocks
        tableView.reloadData()
        print("Number \(stockPriceViewModel.stocks.count)")
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        let content = cell.defaultContentConfiguration()
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
}

