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


class StockPriceViewModel {
    // MARK: - Delegate
    weak var delegate: StockPriceDelegate!
    
    // MARK: - Main data
    var stocks: [Stock] = [Stock]()
    var displayingstocks: [Stock] = [Stock] ()
    
    // MARK: - Managers
    let favoriteStocksManager = FavouriteManager()

    // MARK: - Properties
    var isStockActiveFavorite: Bool = false
    let stockTickers: [String] = [ "AAPL" , "YNDX", "GOOGL" , "AMZN" , "BAC", "MSFT" , "TSLA" ,"WU" ,"WY", "WLTW", "XLNX", "YUM", "ZBRA" ]
    let token: String = "&token=c9t1pkaad3ib0ug34a5g"
    let urlForStockPrice: String = "https://finnhub.io/api/v1/quote?symbol="
    let urlForStockProfile: String = "https://finnhub.io/api/v1/stock/profile2?symbol="
    
    
    // MARK: - Func 
    func parseData(){
        for stockTicker in self.stockTickers {
            self.fetchStockPrice(stockTicker: stockTicker)
        }
    }
    
    // loading price/ticker of company
    private func fetchStockPrice(stockTicker: String){
        let url = urlForStockPrice+stockTicker+token
        if let safeUrl = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: safeUrl) { data, response, error in
                guard error == nil else{
                    print(error!)
                    return
                }
                let decoder = JSONDecoder()
                if let safeData = data {
                    do{
                        var result = try decoder.decode(StockPrice.self, from: safeData)
                        DispatchQueue.main.sync{ [weak self] in
                            var instance = Stock()
                            instance.ticker = stockTicker
                            instance.enteringDataFromStockPrice(stockPrice: result)
                            self?.stocks.append(instance)
                            print(result)
                            self?.fetchStockProfile(stockIndex: (self?.stocks.count ?? 1)-1)
                        }
                    }catch{
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    // loading profile of the company
    private func fetchStockProfile(stockIndex: Int){
        let url = urlForStockProfile+(stocks[stockIndex].ticker!)+token
        if let safeUrl = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: safeUrl) { data, response, error in
                guard error == nil else{
                    print(error)
                    return
                }
                let decoder = JSONDecoder()
                if let safedata = data {
                    do{
                        var result = try decoder.decode(StockProfile.self, from: safedata)
                        DispatchQueue.main.sync { [weak self] in
                            self?.stocks[stockIndex].enteringDataFromStockProfile(stockProfile: result)
                            print(result)
                            self?.LoadLogo(URLAddress: result.logo, stockIndex: stockIndex)
                        }
                    }catch{
                        print(error)
                    }
                }
            }
                .resume()
        }
    }
    
    // Loading logo image
    private func LoadLogo(URLAddress: String, stockIndex: Int){
        guard let url = URL(string: URLAddress) else{
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url){
                if let loadedImage = UIImage(data: imageData){
                    self?.stocks[stockIndex].Logo = loadedImage
                }
            }
            self?.prepareForDisplay()
        }
    }
    
    // Preparing to update viewtable
    private func prepareForDisplay(){
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
}



