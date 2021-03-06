//
//  ViewController.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 07.05.2022.
//

import UIKit

class ViewController: UIViewController 
{
    
    // MARK: - ViewModels
    let stockPriceViewModel = StockPriceViewModel()
    
    // MARK: - PROPERTIRES
    var darkTitleColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    var grayTitleColor = UIColor(red: 0.729, green: 0.729, blue: 0.729, alpha: 1)
    // MARK: - VIEW ELEMENTES
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .equalSpacing
        stack.spacing = 5
        stack.layer.cornerRadius = 20
        return stack
    }()
     
    var stockButton: UIButton = {
        let textButton = UIButton()
        textButton.translatesAutoresizingMaskIntoConstraints = false
        textButton.setTitle("Stocks", for: .normal)
        textButton.setTitleColor( UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
        textButton.titleLabel?.textAlignment = .center
        textButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 40)
        textButton.addTarget(self, action: #selector(stocksTapped(_:)), for: .touchUpInside)
        return textButton
    }()

    var favoriteButton: UIButton = {
        let textButton = UIButton()
        textButton.translatesAutoresizingMaskIntoConstraints = false
        textButton.setTitle("Favorite", for: .normal)
        textButton.setTitleColor(UIColor(red: 0.729, green: 0.729, blue: 0.729, alpha: 1), for: .normal)
        textButton.titleLabel?.textAlignment = .center
        textButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        textButton.addTarget(self, action: #selector(favoriteTapped(_:)), for: .touchUpInside)
        return textButton
    }()
    
    var stackforChoice: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .bottom
        stack.distribution = .equalSpacing
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
        table.separatorStyle = .none
        return table
    }() 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        stockPriceViewModel.delegate = self
        searchBar.delegate = self
        setUpView()
    }
    
    private func setUpView(){
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
        navigationController?.hidesBarsOnSwipe = true
 //       navigationItem.searchController = searchController
 //       navigationItem.hidesSearchBarWhenScrolling = true
 //       navigationItem.largeTitleDisplayMode = .never
 //       navigationController?.navigationBar.prefersLargeTitles = false
 //       //stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(stackforChoice)
        stackView.addArrangedSubview(tableView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        customChoiceStack()
        
        //stackforChoice.heightAnchor.constraint(equalToConstant: 60)
        tableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tableView.topAnchor.constraint(equalTo: stackforChoice.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        //searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        //searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        //searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

    }
    
    private func customChoiceStack(){
        stackforChoice.addArrangedSubview(stockButton)
        stackforChoice.addArrangedSubview(favoriteButton)
        
        stockButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        stockButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        favoriteButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        UIView.transition(with: favoriteButton, duration: 5, options: .curveEaseIn) {
            self.favoriteButton.layoutIfNeeded()
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UIView.transition(with: stockButton, duration: 6, options: .curveLinear) {
            self.stockButton.layoutIfNeeded()
        }
    }
    
    // MARK: - ButtonActions
    
    @objc func favoriteTapped(_ sender: UIButton!){
        guard stockPriceViewModel.isStockActiveFavorite == false else{
            return
        }
        stockPriceViewModel.changeMode()
        UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve) {
            self.stockButton.setTitleColor(self.grayTitleColor, for: .normal)
            self.favoriteButton.setTitleColor(self.darkTitleColor, for: .normal)
            self.tableView.reloadData()
        }
        print("favorite tapped")
    }

    
    @objc func stocksTapped(_ sender: UIButton!){
        guard stockPriceViewModel.isStockActiveFavorite == true else{
            return
        }
        stockPriceViewModel.changeMode()
        UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve) {
            self.stockButton.setTitleColor(self.darkTitleColor, for: .normal)
            self.favoriteButton.setTitleColor(self.grayTitleColor, for: .normal)
            self.tableView.reloadData()
        }
        print("stocks tapped")
        
    }
    
    
    
    
    
    
    
    
}

// MARK: - StockPriceDelegate
extension ViewController: StockPriceDelegate{
    func update() {
        UIView.animate(withDuration: 0.5) {
            self.tableView.reloadData()
        }
        print("Number \(stockPriceViewModel.stocks.count)")
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockPriceViewModel.displayingstocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        cell.favoriteStockManager = stockPriceViewModel.favoriteStocksManager
        cell.setView(stock: stockPriceViewModel.displayingstocks[indexPath.row], index: indexPath.row)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        let detailViewController = DetailViewController()
        detailViewController.stock = stockPriceViewModel.displayingstocks[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let shouldHideNavBar = scrollView.contentOffset.y > 80
        // 20 is an arbitrary number I added to compensate for some of scrolling
        print(scrollView.contentOffset.y)
        UIView.animate(withDuration: 0.5) {
            self.navigationController?.setNavigationBarHidden(shouldHideNavBar, animated: true)
            self.stackView.layoutIfNeeded()
        }
        
        
    }
    
}


// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        stockPriceViewModel.filter(searchWord: searchText)
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        stockPriceViewModel.returningToNormal()
    }
}



