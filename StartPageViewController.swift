//
//  StartPageViewController.swift
//  FinanceApp
//
//  Created by Razvan26 on 02/03/2019.
//  Copyright © 2019 Razvan26. All rights reserved.
//

import UIKit


fileprivate let fileApiKey = "API_KEY"

class StartPageViewController: UIViewController {
    
    let companyNameLb : UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let openLb : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let closeLb : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let latestPriceLb : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        self.view.addSubview(companyNameLb)
        self.view.addSubview(closeLb)
        self.view.addSubview(openLb)
        self.view.addSubview(latestPriceLb)
        self.title = "Apple stock"
        companyNameLb.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        companyNameLb.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        companyNameLb.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
        latestPriceLb.topAnchor.constraint(equalTo: companyNameLb.bottomAnchor, constant: 10).isActive = true
        
        latestPriceLb.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        latestPriceLb.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
        openLb.topAnchor.constraint(equalTo: latestPriceLb.bottomAnchor, constant: 10).isActive = true
        
        openLb.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        openLb.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
        closeLb.topAnchor.constraint(equalTo: openLb.bottomAnchor, constant: 10).isActive = true
        
        closeLb.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        closeLb.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
        guard let url = URL(string: fileApiKey) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            if (err != nil) {
                print("Big error!")
                print("----------")
                print(err?.localizedDescription ?? "")
                print("----------")
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: [])
//                print(jsonResponse)
//                let decoder = JSONDecoder()
//                let model = try decoder.decode([StockData].self, from: data!)
//                print(model)
//                print(jsonResponse)
                if let obj = jsonResponse as? [String : Any] {
                    guard let companyName = obj["companyName"] as? String else {return}
                    guard let open = obj["open"] as? Double else {return}
                    guard let close = obj["close"] as? Double else {return}
                    guard let latestPrice = obj["latestPrice"] as? Double else {return}
                    
                    print(latestPrice)
                    print(close)
                    print(open)
                    print(companyName)
                    
                    
                    
                    DispatchQueue.main.async {
                        self.companyNameLb.text = "Company name : " + companyName
                        self.latestPriceLb.text = "Lastest price : " + "\(latestPrice)"
                        self.openLb.text = "open : " + "\(open)"
                        self.closeLb.text = "close : " + "\(close)"
                    }
                    
                }
                else {
                    print("This is a big error ")
                }
            }
            catch let err {
                print("Is wrong!", err.localizedDescription)
            }
        }
        task.resume()
    }
    
}
