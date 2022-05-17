//
//  Stock.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 17.05.2022.
//

import Foundation

// model that will be used to interact with views

struct Stock {
    var ticker: String?
    var companyName: String?
    var companyLogo: String?
    var price: Double?
    var changeRate: Double?
    var changeRatePercent: Double?
    
    mutating func enteringDataFromStockPrice(stockPrice: StockPrice){
        self.price = stockPrice.c
        self.changeRate = stockPrice.d
        self.changeRatePercent = round(stockPrice.dp*100)/100
    }
    
    mutating func enteringDataFromStockProfile(stockProfile: StockProfile){
        self.companyName = stockProfile.name
        self.companyLogo = stockProfile.logo
        self.ticker = stockProfile.ticker
    }
}
