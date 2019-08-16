//
//  BudgetingPeriod.swift
//  Budget App
//
//  Created by William Leung on 8/3/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class Period {
    
    var name: String
    var income: Double
    var envelopes: [Envelope]
    
    init(name: String, income: Double, envelopes: [Envelope]) {
        self.name = name
        self.income = income
        self.envelopes = envelopes
    }
}
