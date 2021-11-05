//
//  File.swift
//  
//
//  Created by MoneyClip on 2021-02-10.
//

import Foundation
import Network

// MARK: - Delegate

protocol CoinPickerTableViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(error: Error)
}

// MARK: - Object

final class CoinPickerTableViewModel: NSObject {
    
    // MARK: - Private
    
    private var coins = [Coin]()
    
    // MARK: - Public
    
    weak var delegate: CoinPickerTableViewModelDelegate?
    
    var totalCount: Int {
        self.coins.count
    }

    func coin(at indexPath: IndexPath) -> Coin {
        self.coins[indexPath.row]
    }
    
    func coinId(at indexPath: IndexPath) -> String {
        self.coins[indexPath.row].id ?? "bitcoin"
    }
    
    func coinSymbol(at indexPath: IndexPath) -> String {
        self.coins[indexPath.row].symbol ?? "btc"
    }
    
    func coinLogoUrl(at indexPath: IndexPath) -> URL {
        URL(string: "https://cryptologos.cc/logos/\(coinId(at: indexPath))-\(coinSymbol(at: indexPath).lowercased())-logo.png?v=010")!
    }
    
    // MARK: - Init
    
    init(delegate: CoinPickerTableViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Functions
    
    func fetchSymbols() {
        Networking.getData(
            url: URL(string: "https://api.coincap.io/v2/assets?limit=100")!
        ) { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                guard let data = json["data"] as? [[String: Any]] else {
                    return
                }
                let assets = data.map { Coin(json: $0)}
                DispatchQueue.main.async {
                    self.coins.append(contentsOf: assets)
                    self.delegate?.onFetchCompleted()
                }
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.onFetchFailed(error: error)
                }
            }
        }
    }
}
