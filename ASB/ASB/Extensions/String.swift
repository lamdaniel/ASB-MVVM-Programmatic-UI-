//
//  String.swift
//  ASB
//
//  Created by Daniel Lam on 5/02/22.
//

import Foundation

extension String {
    func convertStringToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "E dd MMM yyyy"
        return formatter.date(from: self)!
    }
}
