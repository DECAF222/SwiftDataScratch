//
//  ExpenseModel.swift
//  SwiftDataScratch
//
//  Created by Nitish M on 16/11/25.
//

import Foundation
import SwiftData

@Model
class ExpenseModel{
    @Attribute(.unique) var name: String
    var date: Date
    var amount: Double
    
    init(name: String, date: Date, amount: Double) {
        self.name = name
        self.date = date
        self.amount = amount
    }
}
