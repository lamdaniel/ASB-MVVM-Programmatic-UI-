//
//  TransactionService.swift
//  ASB
//
//  Created by Daniel Lam on 5/02/22.
//

import Foundation

struct TransactionService {
    
    func fetchTransactions(completion: @escaping([Transaction]) -> Void) {
        guard let transactionURL = URL(string: "https://60220907ae8f8700177dee68.mockapi.io/api/v1/transactions") else { return }
        
        URLSession.shared.dataTask(with: transactionURL) { data, response, error in
            if error != nil {
                return
            }
            
            guard let data = data else { return }
            
            let transactionData = try! JSONDecoder().decode([Transaction].self, from: data)
            completion(transactionData)
        }.resume()
    }
}
