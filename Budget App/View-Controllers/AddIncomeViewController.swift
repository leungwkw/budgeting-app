//
//  AddIncomeViewController.swift
//  Budget App
//
//  Created by William Leung on 8/11/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class AddIncomeViewController: UIViewController {

    var callerVC: ManageIncomeViewController!
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var addIncomeTextField: UITextField!
    
    /**
     * Upon typing in the 'addIncomeTextField',
     * immediately updates the number-string to a currency-string.
     */
    @IBAction func didEditAddIncomeTextField(_ sender: UITextField) {
        if let amountString = sender.text?.currencyInputFormatting() {
            sender.text = amountString
        }
    }
    
    /**
     * Upon pressing the 'Add Income' button, checks that 'addIncomeTextField' contains text;
     * if so, adds amount to be added (stated in the 'addIncomeTextField') to the actual period model and then
     * updates the 'incomeLabel' of this view accordingly.
     */
    @IBAction func addIncome(_ sender: Any) {
        if (self.addIncomeTextField.text!.count > 0) {
            let currentPeriod: Period! = self.callerVC.callerVC.currentPeriod
            let amtToAddText = self.addIncomeTextField.text!
            let range = amtToAddText.index(after: amtToAddText.startIndex)..<amtToAddText.endIndex
            currentPeriod.income += Double(amtToAddText[range]) ?? 0
            self.incomeLabel.text = String(currentPeriod.income)
        }
    }
    
    /**
     * When the 'Done' button is pressed, segues back to ManageIncomeView.
     */
    @IBAction func returnToManageIncomeVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /**
     * Method runs after view has been loaded:
     * sets text of 'incomeLabel'.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.incomeLabel.text = String(self.callerVC.callerVC.currentPeriod.income)
    }

}
