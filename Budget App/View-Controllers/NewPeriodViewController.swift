//
//  NewPeriodViewController.swift
//  Budget App
//
//  Created by William Leung on 8/3/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class NewPeriodViewController: UIViewController {
    
    var callerVC: AllPeriodsViewController!

    @IBOutlet weak var newPeriodTextField: UITextField!
    
    /**
     * When the 'Create' button is pressed, checks that 'newPeriodTextField' contains text;
     * if so, appends a new, empty period to list of periods and then segues back to AllPeriodsView.
     */
    @IBAction func createNewPeriod(_ sender: Any) {
        if newPeriodTextField.text!.count > 0 {
            self.callerVC.periods.append(Period(name: newPeriodTextField.text!, income: 0, envelopes: []))
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /**
     * When the 'Cancel' button is pressed, segues back to AllPeriodsView.
     */
    @IBAction func cancelCreatePeriod(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
