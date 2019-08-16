//
//  EnvelopeDetailsViewController.swift
//  Budget App
//
//  Created by William Leung on 8/3/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class EnvelopeDetailsViewController: UIViewController {
    
    public var envelope: Envelope!
    @IBOutlet weak var envelopeNameLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var budgetedLabel: UILabel!
    @IBOutlet weak var filledSpentBar: FilledSpentBar!
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
     * Upon pressing the 'Add Spending' button, checks that 'addSpendingTextField' contains text;
     * if so, adds amount spent (stated in the 'addIncomeTextField') to the actual envelop model and then
     * updates the 'spentLabel' and 'spendingBar' of this view accordingly.
     */
    @IBAction func addSpending(_ sender: Any) {
        
        if (self.addSpendingTextField.text!.count > 0) {
            let amtToAddText = self.addSpendingTextField.text!
            let range = amtToAddText.index(after: amtToAddText.startIndex)..<amtToAddText.endIndex
            self.envelope.amtSpent += Double(amtToAddText[range]) ?? 0
            self.spentLabel.text = String(self.envelope.amtSpent)
            self.filledSpentBar.animateSpentValue(to: CGFloat(self.envelope.amtSpent/self.envelope.amtBudgeted))
        }
    }
    
    /**
     * Method runs after view has been loaded:
     * populates labels and other objects of the view based on the envelope
     * passed in from the PeriodView.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        self.envelopeNameLabel.text = self.envelope.name
        self.spentLabel.text = String(self.envelope.amtSpent)
        self.budgetedLabel.text = String(self.envelope.amtBudgeted)
        self.filledSpentBar.filledValue = CGFloat(self.envelope.amtFilled/self.envelope.amtBudgeted)
        self.filledSpentBar.spentValue = CGFloat(self.envelope.amtSpent/self.envelope.amtBudgeted)
    }
}
