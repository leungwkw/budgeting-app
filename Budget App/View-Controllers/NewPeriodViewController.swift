//
//  NewPeriodViewController.swift
//  Budget App
//
//  Created by William Leung on 8/3/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class NewPeriodViewController: UIViewController {
    
    var callerVC: AllPeriodsViewController?

    @IBOutlet weak var newPeriodTextField: UITextField!
    
    @IBAction func createNewPeriod(_ sender: Any) {
        if let newPeriodName = newPeriodTextField.text {
            self.callerVC?.periods.append(Period(name: newPeriodName, income: 0, envelopes: []))
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelCreate(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
