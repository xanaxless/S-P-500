//
//  StockTableModel.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 27.06.2022.
//

import Foundation
import UIKit

protocol StockTableModelDelegate : class{
    var stocks: [Stock] {get set}
    var displayingstocks: [Stock] {get set}
    func prepareForDisplay()
}

class StockTableModel{
    // MARK: - Delegate
    unowned var delegate: StockTableModelDelegate!
    
    // MARK: - Properties
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
                        let result = try decoder.decode(StockPrice.self, from: safeData)
                        DispatchQueue.global(qos:.userInteractive).async { [weak self] in
                            var instance = Stock()
                            instance.ticker = stockTicker
                            instance.enteringDataFromStockPrice(stockPrice: result)
                            self?.delegate.stocks.append(instance)
                            print(result)
                            self?.fetchStockProfile(stockIndex: (self?.delegate.stocks.count ?? 1)-1)
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
        let url = urlForStockProfile+(self.delegate.stocks[stockIndex].ticker!)+token
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
                        let result = try decoder.decode(StockProfile.self, from: safedata)
                        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                            self?.delegate.stocks[stockIndex].enteringDataFromStockProfile(stockProfile: result)
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
                    self?.delegate.stocks[stockIndex].Logo = loadedImage
                }
            }
            self?.delegate.prepareForDisplay()
        }
    }
}
