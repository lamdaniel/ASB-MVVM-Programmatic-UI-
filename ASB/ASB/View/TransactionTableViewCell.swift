//
//  TransactionTableViewCell.swift
//  ASB
//
//  Created by Daniel Lam on 5/02/22.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    private let summaryLabel: UILabel = {
        let label = UILabel()

        return label
    }()
    
    private let creditDebitLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    var transaction: Transaction? {
        didSet {
            setupCell()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [summaryLabel, creditDebitLabel])
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        addSubview(stackView)
        stackView.centerY(inView: self)
        stackView.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
    }
    
    private func setupCell() {
        if let transaction = transaction {
            summaryLabel.text = transaction.summary
            creditDebitLabel.text = "TEST"
        }
    }
}
