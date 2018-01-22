//
//  ViewController2.swift
//  Bitcoin Cash
//
//  Created by Carter Belisle on 12/19/17.
//  Copyright © 2017 Carter B. All rights reserved.
//

import Foundation
import UIKit
class ViewController2: UIViewController {
    @IBOutlet var myWebView2: UIWebView!
    @IBOutlet var PriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getPrice()
    }
    func getPrice() {
        let Weburl = URL(string: "http://www.savage.ws/twitterBCASH.html")
        myWebView2.loadRequest(URLRequest(url: Weburl!))
        
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
    @IBAction func refreshCLicked(_ sender: Any) {
        print("Clicked")
        getPrice()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
