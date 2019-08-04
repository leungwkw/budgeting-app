//
//  DetailsViewController.swift
//  Budget App
//
//  Created by William Leung on 8/3/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class EnvelopeDetailsViewController: UIViewController {
    
    public var envelope: Envelope?
    @IBOutlet weak var envelopeNameLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var budgetedLabel: UILabel!
    @IBOutlet weak var spendingBar: SpendingBar!
    @IBOutlet weak var addSpendingTextField: UITextField!
    
    /**
     * Upon typing in the 'addSpendingTextField',
     * immediately updates the number-string to a currency-string.
     */
    @IBAction func didEdit(_ sender: UITextField) {
        if let amountString = sender.text?.currencyInputFormatting() {
            sender.text = amountString
        }
    }
    
    /**
     * Upon pressing the 'Add Spending' button,
     * adds amount spent (stated in the 'addSpendingTextField') to the actual envelop model and then
     * updates the 'spentLabel' and 'spendingBar' of this view accordingly.
     */
    @IBAction func addSpending(_ sender: Any) {
        if let amtToAddText = self.addSpendingTextField.text {
            if let envelope = self.envelope {
                let range = amtToAddText.index(after: amtToAddText.startIndex)..<amtToAddText.endIndex
                envelope.amtSpent += Double(amtToAddText[range]) ?? 0
                self.spentLabel.text = String(envelope.amtSpent)
                self.spendingBar.animateValue(to: CGFloat(envelope.amtSpent/envelope.amtBudgeted))
            }
        }
    }
    
    /**
     * Method runs after view has been loaded:
     * populates labels and other objects of the view based on the envelope
     * passed in from the Period-View.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        if let envelope = self.envelope {
            self.envelopeNameLabel.text = envelope.name
            self.spentLabel.text = String(envelope.amtSpent)
            self.budgetedLabel.text = String(envelope.amtBudgeted)
            self.spendingBar.value = CGFloat(envelope.amtSpent/envelope.amtBudgeted)
        }
    }
}

/**
 * Extension for 'String' class that allows for currency-string-formatting.
 */
extension String {
    
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
