//
//  Transaction.swift
//  ASB
//
//  Created by Daniel Lam on 5/02/22.
//

import Foundation

struct Transaction: Decodable {
    
    let id: String
    let transactionDate: String
    let summary: String
    let debit: Double
    let credit: Double
    var isCredit: Bool {
        return credit != 0.0
    }
    
}
