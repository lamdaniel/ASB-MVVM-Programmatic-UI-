//
//  ViewController.swift
//  ASB
//
//  Created by Daniel Lam on 5/02/22.
//

import UIKit

class TransactionsViewController: UIViewController {
    
    private let transactionsViewModel = TransactionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        callToViewModelForTransactions()
    }

    private func configureUI() {
        view.backgroundColor = .white
    }

    private func callToViewModelForTransactions() {
        transactionsViewModel.listener = {
            print(self.transactionsViewModel.transactions)
        }
        
        transactionsViewModel.callFuncToGetTransactionData()
    }
}

