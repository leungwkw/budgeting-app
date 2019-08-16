//
//  NewEnvelopeViewController.swift
//  Budget App
//
//  Created by William Leung on 8/4/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class NewEnvelopeViewController: UIViewController {

    var callerVC: PeriodViewController!
    
    @IBOutlet weak var envelopeNameTextField: UITextField!
    @IBOutlet weak var amtBudgetedTextField: UITextField!
    
    /**
     * Upon typing in the 'amtBudgetedTextField',
     * immediately updates the number-string to a currency-string.
     */
    @IBAction func didEditAmtBudgetedTextField(_ sender: UITextField) {
        if let amountString = sender.text?.currencyInputFormatting() {
            sender.text = amountString
        }
    }
    
    /**
     * When the 'Create' button is pressed, checks that 'envelopeNameTextField' and
     * 'amtBudgetedTextField' contain text; if so, appends a new, empty envelope to
     * list of envelopes and then segues back to PeriodView.
     */
    @IBAction func createNewEnvelope(_ sender: Any) {
        if (self.envelopeNameTextField.text!.count > 0) && (self.amtBudgetedTextField.text!.count > 0) {
                
            let newEnvelopeName = self.envelopeNameTextField.text!
            let amtBudgetedText = self.amtBudgetedTextField.text!
            
            let range = amtBudgetedText.index(after: amtBudgetedText.startIndex)..<amtBudgetedText.endIndex
            
            if let amtBudgetedDbl = Double(amtBudgetedText[range]) {
                self.callerVC.currentPeriod.envelopes.append(Envelope(name: newEnvelopeName, amtBudgeted: amtBudgetedDbl, amtFilled: 0, amtSpent: 0))
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    /**
     * When the 'Cancel' button is pressed, segues back to PeriodView.
     */
    @IBAction func cancelCreateEnvelope(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
