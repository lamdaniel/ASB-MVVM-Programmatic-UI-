//
//  ViewController.swift
//  ASB
//
//  Created by Daniel Lam on 5/02/22.
//

import UIKit

private let reuseIdentifier = "TransactionsCell"

class TransactionsTableViewController: UITableViewController {
        
    private let transactionsViewModel = TransactionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureNavigationBar()
        configureTableView()
        callToViewModelForTransactions()
    }

    private func configureUI() {
        view.backgroundColor = .white
        
    }
    
    private func configureNavigationBar() {
        title = "Transactions"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactionsViewModel.transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = transactionsViewModel.transactions[indexPath.row].summary
        return cell
    }
}
