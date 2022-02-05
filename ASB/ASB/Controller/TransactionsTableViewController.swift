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
    
    private var transactions: [Transaction] = [] {
        didSet {
            createSections()
        }
    }
    private var sections: [DateSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

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
            self.transactions = self.transactionsViewModel.transactions
        }
        
        transactionsViewModel.callFuncToGetTransactionData()
    }
    
    private func createSections() {
        let groups = Dictionary(grouping: transactions, by: {$0.formatTransactionDate()})
        
        sections = groups.map { (key, values) in
            return DateSection(date: key, transaction: values)
        }
        
        sections.sort{(lhs, rhs) in (lhs.date.convertStringToDate()) > (rhs.date.convertStringToDate())}
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].date
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].transaction.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].transaction[indexPath.row].summary
        return cell
    }
}
