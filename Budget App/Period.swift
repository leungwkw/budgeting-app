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
    var envelopes: [Envelope]
    
    init(name: String, envelopes: [Envelope]) {
        self.name = name
        self.envelopes = envelopes
    }
}
