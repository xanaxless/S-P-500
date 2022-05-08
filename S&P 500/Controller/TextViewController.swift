//
//  TextViewController.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 07.05.2022.
//

import UIKit

class TextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let textLabel = UILabel()
        textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textLabel.text = "Stocks"
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
