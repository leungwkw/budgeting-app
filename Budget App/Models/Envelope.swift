//
//  Envelope.swift
//  Budget App
//
//  Created by William Leung on 7/30/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class Envelope {
    
    var name: String
    var amtBudgeted: Double
    var amtFilled: Double
    var amtSpent: Double
    
    init(name: String, amtBudgeted: Double, amtFilled: Double, amtSpent: Double) {
        self.name = name
        self.amtBudgeted = amtBudgeted
        self.amtFilled = amtFilled
        self.amtSpent = amtSpent
    }
}
