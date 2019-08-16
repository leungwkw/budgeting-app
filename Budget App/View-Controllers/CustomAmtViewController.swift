//
//  CustomAmtViewController.swift
//  Budget App
//
//  Created by William Leung on 8/11/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class CustomAmtViewController: UIViewController {

    var callerVC: ManageIncomeViewController!
    
    @IBOutlet weak var customAmtTextField: UITextField!
    
    /**
     * Upon typing in the 'customAmtTextField',
     * immediately updates the number-string to a currency-string.
     */
    @IBAction func didEditCustomAmtTextField(_ sender: UITextField) {
        if let amountString = sender.text?.currencyInputFormatting() {
            sender.text = amountString
        }
    }
    
    /**
     * When the 'Add to Selected' button is pressed, checks that 'addIncomeTextField' contains text;
     * if so, attempts to top up all the selected envelopes by the specified amounts
     * (ie. attempts to top up the 'amtFilled' property of each selected envelope by the specified amount).
     * Displays an error alert if there is insufficient income.
     * If operation is completes successfully, segues back to ManageIncomeView.
     */
    @IBAction func addCustomAmtToSelected(_ sender: Any) {
        
        if self.customAmtTextField.text!.count > 0 {
            let amtToAddText = self.customAmtTextField.text!
            let range = amtToAddText.index(after: amtToAddText.startIndex)..<amtToAddText.endIndex
            let amtToAdd = Double(amtToAddText[range]) ?? 0
            
            var totalIncomeToDeduct = 0.0
            for e in self.callerVC.selectedEnvelopes {
                if (e.amtBudgeted - e.amtFilled < amtToAdd) {
                    totalIncomeToDeduct += e.amtBudgeted - e.amtFilled
                }
                else {
                    totalIncomeToDeduct += amtToAdd
                }
            }
            
            if totalIncomeToDeduct > self.callerVC.callerVC.currentPeriod.income {
                let alert = UIAlertController(title: "Insufficient Income", message: "To add this amount to the selected envelopes, first add more income.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                for e in self.callerVC.selectedEnvelopes {
                    if (e.amtBudgeted - e.amtFilled < amtToAdd) {
                        e.amtFilled = e.amtBudgeted
                    }
                    else {
                        e.amtFilled += amtToAdd
                    }
                }
                self.callerVC.callerVC.currentPeriod.income -= totalIncomeToDeduct
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    /**
     * When the 'Cancel' button is pressed, segues back to ManageIncomeView.
     */
    @IBAction func cancelAddCustomAmt(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
