//
//  ViewController.swift
//  ASB
//
//  Created by Daniel Lam on 5/02/22.
//

import UIKit

private let reuseIdentifier = "TransactionsCell"

class TransactionsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private let transactionsViewModel = TransactionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureTableView()
        callToViewModelForTransactions()
    }

    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    private func callToViewModelForTransactions() {
        transactionsViewModel.listener = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        transactionsViewModel.callFuncToGetTransactionData()
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactionsViewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = transactionsViewModel.transactions[indexPath.row].summary
        return cell
    }
    
    
}

extension TransactionsViewController: UITableViewDelegate {
    
}
