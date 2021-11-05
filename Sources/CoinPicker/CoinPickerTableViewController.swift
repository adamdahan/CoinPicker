//
//  File.swift
//
//
//  Created by MoneyClip on 2021-02-09.
//

import UIKit
import Kingfisher

public class CoinPickerViewController: UIViewController {
    
    private struct Constants {
        static let rowHeight: CGFloat = 80.0
    }
    
    // MARK: - Private
    
    /// Don't want anyone to have to initialize this from the outside.
    private lazy var viewModel: CoinPickerTableViewModel = {
        return CoinPickerTableViewModel(delegate: self)
    }()
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.dataSource = self
        t.delegate = self
        t.rowHeight = Constants.rowHeight
        t.estimatedRowHeight = Constants.rowHeight
        t.register(
            CoinPickerTableViewCell.self,
            forCellReuseIdentifier: String(describing: CoinPickerTableViewCell.self)
        )
        return t
    }()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchSymbols()
    }
    
    private func setup() {
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo:  view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CoinPickerViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.totalCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CoinPickerTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: CoinPickerTableViewCell.self),
            for: indexPath
        ) as! CoinPickerTableViewCell
        
        let coin = self.viewModel.coin(at: indexPath)
        let coinUrl = self.viewModel.coinLogoUrl(at: indexPath)
        cell.coinSymbol.text = coin.symbol
        cell.coinImageView.kf.setImage(with: coinUrl)
        cell.coinPrice.text = coin.formattedPrice
        return cell
    }
}

extension CoinPickerViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CoinPickerViewController: CoinPickerTableViewModelDelegate {
    
    func onFetchCompleted() {
        tableView.reloadData()
    }
    
    func onFetchFailed(error: Error) {
        print(error.localizedDescription)
    }
}
