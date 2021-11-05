//
//  CoinPickerTableViewCell.swift
//  
//
//  Created by MoneyClip on 2021-02-10.
//

import UIKit

class CoinPickerTableViewCell: UITableViewCell {
    
    private struct Constants {
        static let diameter: CGFloat = 40.0
        static let padding: CGFloat = 20.0
    }

    let coinImageView = UIImageView()
    let coinSymbol = UILabel()
    let coinPrice = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupCoinImageView()
        setupCoinSymbol()
        setupCoinPrice()
    }
    
    private func setupCoinImageView() {
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coinImageView)
        NSLayoutConstraint.activate([
            coinImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            coinImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            coinImageView.widthAnchor.constraint(equalToConstant: Constants.diameter),
            coinImageView.heightAnchor.constraint(equalToConstant: Constants.diameter)
        ])
    }
    
    private func setupCoinSymbol() {
        coinSymbol.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coinSymbol)
        NSLayoutConstraint.activate([
            coinSymbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding * 4),
            coinSymbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinSymbol.widthAnchor.constraint(equalToConstant: Constants.diameter * 2),
            coinSymbol.heightAnchor.constraint(equalToConstant: Constants.diameter)
        ])
    }
    
    private func setupCoinPrice() {
        coinPrice.textAlignment = .right
        coinPrice.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coinPrice)
        NSLayoutConstraint.activate([
            coinPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            coinPrice.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinPrice.widthAnchor.constraint(equalToConstant: Constants.diameter * 4),
            coinPrice.heightAnchor.constraint(equalToConstant: Constants.diameter)
        ])
    }
}
