//
//  StockPriceViewModel.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 10.05.2022.
//

import Foundation

protocol StockPriceDelegate: class{
    func update()
}


class StockPriceViewModel {
    weak var delegate: StockPriceDelegate!
    
    var stocks: [StockPrice] = [StockPrice]()
    
    let stockIndexs: [String] = [ "AAPL" , "YNDX", "GOOGL" , "AMZN" , "BAC", "MSFT" , "TSLA" , "MA"]
    let token: String = "&token=c9t1pkaad3ib0ug34a5g"
    let url: String = "https://finnhub.io/api/v1/quote?symbol="
    
    
    func parseData(){
        for stockIndex in self.stockIndexs {
            self.fetchStock(stockIndex: stockIndex)
        }
        print("Number \(stocks.count)")
    }
    
    private func fetchStock(stockIndex: String){
        let urlStock = url+stockIndex+token
        if let safeUrl = URL(string: urlStock){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: safeUrl) { data, response, error in
                guard error == nil else{
                    return
                }
                let decoder = JSONDecoder()
                if let safeData = data {
                    do{
                        var result = try decoder.decode(StockPrice.self, from: safeData)
                        DispatchQueue.main.sync{
                            result.index = stockIndex
                            self.stocks.append(result)
                            print(result)
                            self.delegate.update()
                        }
                    }catch{
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    
    
}
