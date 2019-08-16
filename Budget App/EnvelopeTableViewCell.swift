//
//  EnvelopeTableViewCell.swift
//  Budget App
//
//  Created by William Leung on 8/2/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class EnvelopeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var envelopNameLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var budgetedLabel: UILabel!
    @IBOutlet weak var filledSpentBar: FilledSpentBar!
    
}
