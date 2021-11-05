//
//  Coin.swift
//
//
//  Created by MoneyClip on 2021-02-09.
//

import Foundation
import Kingfisher

struct Coin: Hashable, Codable, Identifiable {
    var id: String?
    var rank: String?
    var symbol: String?
    var supply: String?
    var maxSupply: String?
    var marketCapUsd: String?
    var volumeUsd24Hr: String?
    var priceUsd: String?
    var changePercent24Hr: String?
    var vwap24Hr: String?
    
    init(json: [String: Any]) {
        
        if let id = json["id"] as? String {
            self.id = id
        }
        
        if let rank = json["rank"] as? String {
            self.rank = rank
        }
        
        if let symbol = json["symbol"] as? String {
            self.symbol = symbol
        }
        
        if let supply = json["supply"] as? String {
            self.supply = supply
        }
        
        if let maxSupply = json["maxSupply"] as? String {
            self.maxSupply = maxSupply
        }
        
        if let volumeUSD = json["volumeUsd24Hr"]  as? String {
            self.volumeUsd24Hr = volumeUSD
        }
        
        if let priceUsd = json["priceUsd"] as? String {
            self.priceUsd = priceUsd
        }
        
        if let changePercent24Hr = json["changePercent24Hr"] as? String {
            self.changePercent24Hr = changePercent24Hr
        }
        
        if let vwap24Hr = json["vwap24Hr"] as? String {
            self.vwap24Hr = vwap24Hr
        }
    }
    
    var formattedPrice: String {
        guard let priceUsd = priceUsd, let doubled = Double(priceUsd) else {
            return "_.__"
        }
        return String(format: "$%.5f", doubled)
    }
}
