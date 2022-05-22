//
//  FavouriteManager.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 19.05.2022.
//

import Foundation

class FavouriteManager {
    let filename = "favouriteStocksFile"
    let fileformat = "plist"
    var favouriteStocks: [String] = []
    
    init() {
        loadStocksArray()
        print(favouriteStocks)
    }
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadStocksArray(){
        let documentsDirectory = getDocumentsDirectory()
        let archiveURL = documentsDirectory.appendingPathComponent(filename).appendingPathExtension(fileformat)
        let decoder = PropertyListDecoder()
        if let data = try? Data(contentsOf: archiveURL){
            if let decodedArray = try? decoder.decode(Array<String>.self, from: data){
                favouriteStocks = decodedArray
            }
        }
    }
    
    func saveStocksArray(){
        let documentsDirectory = getDocumentsDirectory()
        let archiveURL = documentsDirectory.appendingPathComponent(filename).appendingPathExtension(fileformat)
        let encoder = PropertyListEncoder()
        if let encodedArray = try? encoder.encode(favouriteStocks) {
            try? encodedArray.write(to: archiveURL, options: .atomic)
        }
    }
    
    func addStock(stock : String) {
        favouriteStocks.append(stock)
        saveStocksArray()
    }
    
    func removeStock(stock : String){
        for (index, element) in favouriteStocks.enumerated() {
            if(element == stock){
                favouriteStocks.remove(at: index)
                break
            }
        }
    }
    
    
}
