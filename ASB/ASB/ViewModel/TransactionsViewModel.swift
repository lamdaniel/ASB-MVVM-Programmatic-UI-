//
//  TransactionsViewModel.swift
//  ASB
//
//  Created by Daniel Lam on 5/02/22.
//

import Foundation

class TransactionViewModel: NSObject {
        
    private var transactionService = TransactionService()
    private(set) var transactions: [Transaction] = [] {
        didSet {
            self.listener()
        }
    }
    
    var listener: (() -> ()) = {}
    
    override init() {
        super.init()

    }
    
    func callFuncToGetTransactionData() {
        self.transactionService.fetchTransactions { transactions in
            self.transactions = transactions
        }
    }
    
}
