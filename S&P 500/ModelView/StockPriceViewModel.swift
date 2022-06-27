//
//  StockPriceViewModel.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 10.05.2022.
//

import Foundation
import UIKit

protocol StockPriceDelegate: class{
    func update()
}


class StockPriceViewModel: StockTableModelDelegate {
    // MARK: - Delegate
    unowned var delegate: StockPriceDelegate!
    var stockTableModel = StockTableModel()
    
    
    // MARK: - Main data
    var stocks: [Stock] = [Stock]()
    var displayingstocks: [Stock] = [Stock] ()
    
    // MARK: - Properties
    var isStockActiveFavorite: Bool = false
    
    // MARK: - Managers
    let favoriteStocksManager = FavouriteManager()


    
    init() {
        stockTableModel.delegate = self
        stockTableModel.parseData()
    }
    
    
    
    // Preparing to update viewtable
     func prepareForDisplay(){
        if isStockActiveFavorite{
            displayingstocks.removeAll()
            for item in stocks {
                if(favoriteStocksManager.favouriteStocks.contains(item.ticker ?? "")){
                    displayingstocks.append(item)
                }
            }
        }else{
            displayingstocks=stocks
        }
        self.delegate.update()
    }
    
    // Get message from delegate to change mode of display
    func changeMode(){
        isStockActiveFavorite.toggle()
        prepareForDisplay()
    }
    
    // filtering for the search
    func filter(searchWord: String){
        var length = searchWord.count
        displayingstocks = stocks.filter { item in
            if(item.ticker?.count ?? 0 >= length){
                if let prefix = item.ticker?.prefix(length){
                    if prefix == searchWord{
                        return true
                    }
                }
            }
            if(item.companyName?.count ?? 0 >= length){
                if let prefix = item.companyName?.prefix(length){
                    if prefix == searchWord{
                        return true
                    }
                }
            }
            return false
        }
        self.delegate.update()
    }
    
    // returning to normal state
    func returningToNormal(){
        prepareForDisplay()
    }
    
}




