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
        tableView.rowHeight = 60
        
        return tableView
    }()
    
    private let transactionsViewModel = TransactionViewModel()
    
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
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func configureNavigationBar() {
        title = "Transactions"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    private func callToViewModelForTransactions() {
        transactionsViewModel.listener = {
            self.createSections(transactions: self.transactionsViewModel.transactions)
        }
        
        transactionsViewModel.callFuncToGetTransactionData()
    }
    
    private func createSections(transactions: [Transaction]) {
        let groups = Dictionary(grouping: transactions, by: {$0.formatTransactionDate()})
        
        sections = groups.map { (key, values) in
            return DateSection(date: key, transaction: values)
        }
        
        sections.sort{(lhs, rhs) in (lhs.date.convertStringToDate()) > (rhs.date.convertStringToDate())}
    }
   
}

extension TransactionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].date
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].transaction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TransactionTableViewCell
        cell.transaction = sections[indexPath.section].transaction[indexPath.row]
        return cell
    }
}

extension TransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transactionDetailVC = TransactionDetailViewController()
        transactionDetailVC.transaction = sections[indexPath.section].transaction[indexPath.row]
        navigationController?.pushViewController(transactionDetailVC, animated: true)
        
    }
}
