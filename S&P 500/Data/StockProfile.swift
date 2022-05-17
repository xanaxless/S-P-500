//
//  StockProfile.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 17.05.2022.
//

import Foundation

/* used to parse information about stock profile from https://finnhub.io/api/v1/stock/profile2?symbol=AAPL&token="yourtoken"
 */

struct StockProfile: Codable{
    var logo: String // logo of the company
    var name: String //name of the company
    var ticker: String //ticker of the stock
}
