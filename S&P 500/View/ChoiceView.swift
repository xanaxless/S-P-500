//
//  ChoiceView.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 07.05.2022.
//

import UIKit

class ChoiceView: UIView {

    var isShowingFavorite: Bool = false
    let stackView:UIStackView = UIStackView()
    let stocksLabel:UITextView = UITextView()
    let favoriteLabel:UITextView = UITextView()
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCustomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomView(){
        stocksLabel.translatesAutoresizingMaskIntoConstraints = false
        stocksLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        stocksLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stocksLabel.textAlignment = .center
        stocksLabel.text = "Stocks"
        stocksLabel.isEditable = false
        stocksLabel.isScrollEnabled = false
        stocksLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
        favoriteLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        favoriteLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        favoriteLabel.textAlignment = .center
        favoriteLabel.text = "Favorite"
        favoriteLabel.isEditable = false
        favoriteLabel.isScrollEnabled = false
        favoriteLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 50
        stackView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        stackView.addArrangedSubview(stocksLabel)
        stackView.addArrangedSubview(favoriteLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
