//
//  ViewController.swift
//  Bitcoin Cash
//
//  Created by Carter Belisle on 12/19/17.
//  Copyright © 2017 Carter B. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var average: UILabel!
    @IBOutlet var vol: UILabel!
    @IBOutlet var low: UILabel!
    @IBOutlet var high: UILabel!
    @IBOutlet var AveragePriceLabel: UILabel!
    @IBOutlet var FPODPriceLabel: UILabel!
    @IBOutlet var LowPriceLabel: UILabel!
    @IBOutlet var HighPriceLabel: UILabel!
    @IBOutlet var priceChangeLabel: UILabel!
    @IBOutlet var PriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.priceChangeLabel.layer.cornerRadius = 10
         self.high.layer.cornerRadius = 8
        self.low.layer.cornerRadius = 8
         self.vol.layer.cornerRadius = 8
         self.average.layer.cornerRadius = 8
        getPrice()
        getStats()
        getChangeFrom1H()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func getStats() {
        let jsonUrlString = "https://www.bitstamp.net/api/v2/ticker_hour/bchusd/"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                //print(json)
                
                let BCASHHigh24h = json["high"]!
                let BCASHHigh24hUSD = "$" + "\(BCASHHigh24h)"
                let BCASHLow24h = json["low"]!
                let BCASHLow24hUSD = "$" + "\(BCASHLow24h)"
                let BCASHAveragePrice = json["vwap"]!
                let BCASHAveragePriceUSD = "$" + "\(BCASHAveragePrice)"
                let BCASHVolume = json["volume"]!
                
                let BCASHVolumeAsInt = (BCASHVolume as! NSString).intValue
                let BCASHVolumeUSD = "\(BCASHVolumeAsInt)" + " BCH"
                
                DispatchQueue.main.async(execute: {
                    
                    self.HighPriceLabel.text = BCASHHigh24hUSD
                    self.LowPriceLabel.text = BCASHLow24hUSD
                    self.AveragePriceLabel.text = BCASHAveragePriceUSD
                    self.FPODPriceLabel.text = BCASHVolumeUSD
                    
                })
                
                
            }catch let jsonErr {
                print("Error Serializing.", jsonErr)
            }
            
            
            
            
            
            }.resume()
    }
    
    func getPrice() {
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
    
    func getChangeFrom1H () {
        
        let jsonUrlString = "https://api.cryptonator.com/api/ticker/BCH-usd"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                
                let ticker = json["ticker"] as! [String :Any]
                
                let change = ticker["change"]
                let changeInt = (change as! NSString).doubleValue
                let numberOfPlaces = 2.0
                let multiplier = pow(10.0, numberOfPlaces)
                let changeRounded = round(changeInt * multiplier) / multiplier
                let changeUSD = "$" + "\(changeRounded)"
                
                DispatchQueue.main.async(execute: {
                    if (changeInt > 0) {
                        self.priceChangeLabel.text = "▲ " + changeUSD
                        
                    } else {
                        self.priceChangeLabel.text = "▼ " + changeUSD
                        
                    }
                    
                    
                })
                
                
            }catch let jsonErr {
                print("Error Serializing.", jsonErr)
            }
            
            
            
            
            
            }.resume()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func refreshClicked(_ sender: Any) {
        print("Clicked")
        getPrice()
        sleep(UInt32(0.5))
        getStats()
        sleep(UInt32(0.5))
        getChangeFrom1H()
        sleep(UInt32(0.5))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


