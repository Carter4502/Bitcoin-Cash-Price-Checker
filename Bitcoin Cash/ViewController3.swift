//
//  ViewController3.swift
//  Bitcoin Cash
//
//  Created by Carter Belisle on 12/19/17.
//  Copyright © 2017 Carter B. All rights reserved.
//

import Foundation
import UIKit

class ViewController3: UIViewController {
    @IBOutlet var PriceLabel: UILabel!
    @IBOutlet var myWebView3: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getPrice()
        
    }
    func getPrice() {
        let Weburl2 = URL(string: "http://www.savage.ws/graphBCASH.html")
        myWebView3.loadRequest(URLRequest(url: Weburl2!))
        
        let jsonUrlString = "https://min-api.cryptocompare.com/data/price?fsym=BCH&tsyms=USD"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                //print(json)
                let priceOfBCASH = json["USD"]!
                let priceOfBCASHUSD = "$" + "\(priceOfBCASH)"
                
                
                
                DispatchQueue.main.async(execute: {
                    self.PriceLabel.text = priceOfBCASHUSD
                    
                })
                
                
            }catch let jsonErr {
                print("Error Serializing.", jsonErr)
            }
            
            
            
            
            
            }.resume()
        
    }
    @IBAction func refreshhclick(_ sender: Any) {
        print("Clicked")
        getPrice()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
