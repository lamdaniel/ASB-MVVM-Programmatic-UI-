//
//  TransactionDetailViewController.swift
//  ASB
//
//  Created by Daniel Lam on 5/02/22.
//

import UIKit

class TransactionDetailViewController: UIViewController {
    
    var transaction: Transaction?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        if let transaction = transaction {
            print(transaction.summary)
        }
    }

    private func configureUI() {
        view.backgroundColor = .white
    }
}
