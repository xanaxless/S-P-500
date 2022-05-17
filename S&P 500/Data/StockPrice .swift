//
//  StockPrice .swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 10.05.2022.
//

import Foundation

/* used to parse information about stock profile from https://finnhub.io/api/v1/quote?symbol=AAPL&token="your token"
 */


struct StockPrice: Codable {
    var c: Double // Current price
    var d: Double  // Change
    var dp: Double // Percent change
    var h: Double  // High price of the day
    var l: Double // Low price of the day
    var o: Double // Open price of the day
    var pc: Double // Previous close price
}
