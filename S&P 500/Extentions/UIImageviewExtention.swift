//
//  UIImageviewExtention.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 17.05.2022.
//

import Foundation
import UIKit

extension UIImageView{
    func loadFrom(URLAddress: String){
        guard let url = URL(string: URLAddress) else{
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url){
                if let loadedImage = UIImage(data: imageData){
                    self?.image = loadedImage
                }
            }
        }
    }
}
