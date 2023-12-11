//
//  Transaction.swift
//  ExpenseX
//
//  Created by 方泽堃 on 12/10/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Transaction: Codable {
    @DocumentID var id: String?
    var amount: Double
    var category: String
    var isIncome: Bool
    var description: String
    var date: Date
    
    init(amount: Double, category: String, isIncome: Bool, description: String, date: Date) {
        self.amount = amount
        self.category = category
        self.isIncome = isIncome
        self.description = description
        self.date = date
    }
}

