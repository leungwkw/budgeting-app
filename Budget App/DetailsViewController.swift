//
//  DetailsViewController.swift
//  Budget App
//
//  Created by William Leung on 8/3/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    public var envelope: Envelope?
    @IBOutlet weak var envelopeNameLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var budgetedLabel: UILabel!
    @IBOutlet weak var spendingBar: SpendingBar!
    @IBOutlet weak var addSpendingTextField: UITextField!
    
    @IBAction func didEdit(_ sender: UITextField) {
        if let amountString = sender.text?.currencyInputFormatting() {
            sender.text = amountString
        }
    }
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = envelope?.name
        // Do any additional setup after loading the view.
        
        if let envelope = self.envelope {
            self.envelopeNameLabel.text = envelope.name
            self.spentLabel.text = String(envelope.amtSpent)
            self.budgetedLabel.text = String(envelope.amtBudgeted)
            self.spendingBar.value = CGFloat(envelope.amtSpent/envelope.amtBudgeted)
        }
        
        
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension String {
    
    // formatting text for currency textField
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
