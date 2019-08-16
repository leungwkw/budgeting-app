//
//  ManageIncomeViewController.swift
//  Budget App
//
//  Created by William Leung on 8/4/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class ManageIncomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var callerVC: PeriodViewController!
    var selectedEnvelopes: [Envelope] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var incomeLabel: UILabel!
    
    /**
     * Informs table view of the number of sections in table.
     * Will always be 2 sections: the current period's envelopes and the long-term envelopes
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.callerVC.sectionHeaders.count
    }
    
    /**
     * Informs table view of title of given section.
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.callerVC.sectionHeaders[section]
    }
    
    /**
     * Capitalizes the table section title.
     */
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.text = headerView.textLabel?.text?.uppercased()
    }
    
    /**
     * Informs table view of the number of rows in given section.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return self.callerVC.currentPeriod.envelopes.count
        }
        else {
            return self.callerVC.longTermEnvelopes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseableFillingStatusCell", for: indexPath)
        
        /*
         * Identifies envelope that should be used to populate the table cell we need to supply.
         */
        let currentEnvelope: Envelope
        if indexPath.section == 0 {
            currentEnvelope = self.callerVC.currentPeriod.envelopes[indexPath.row]
        }
        else {
            currentEnvelope = self.callerVC.longTermEnvelopes[indexPath.row]
        }
        
        /*
         * Sets properties of table cell according to 'currentEnvelope' properties.
         */
        cell.textLabel?.text = String(currentEnvelope.name)
        cell.detailTextLabel?.text = String(currentEnvelope.amtFilled) + " / " + String(currentEnvelope.amtBudgeted)
        
        /*
         * Marks the cell with a checkmark if the cell had previously been selected.
         */
        if selectedEnvelopes.contains(where: {$0 === currentEnvelope}) {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    /**
     * Upon selecting a table cell, if it is unmarked, then marks it with a check mark and adds the
     * associated envelope to the array, 'selectedEnvelopes' OR
     * if the cell is already marked, unmarks it and removes it from the 'selectedEnvelopes' array.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            if indexPath.section == 0 {
                self.selectedEnvelopes.removeAll(where: {$0 === self.callerVC.currentPeriod.envelopes[indexPath.row]})
            }
            else {
                self.selectedEnvelopes.removeAll(where: {$0 === self.callerVC.longTermEnvelopes[indexPath.row]})
            }
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            if indexPath.section == 0 {
                self.selectedEnvelopes.append(self.callerVC.currentPeriod.envelopes[indexPath.row])
            }
            else {
                self.selectedEnvelopes.append(self.callerVC.longTermEnvelopes[indexPath.row])
            }
        }
    }
    
    /**
     * When the 'Add Income' button is pressed, segues to AddIncomeView.
     */
    @IBAction func addIncome(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddIncomeView", sender: sender)
    }
    
    /**
     * When the 'Fill Selected' button is pressed, attempts to fill all the selected envelopes using
     * the user's income (ie. attempts to top up the 'amtFilled' property for each of those envelopes to
     * match the respective 'amtBudgeted' property).
     * Displays an error alert if there is insufficient income.
     */
    @IBAction func fillSelectedEnvelopes(_ sender: Any) {
        var totalIncomeToDeduct = 0.0
        for e in self.selectedEnvelopes {
            totalIncomeToDeduct += e.amtBudgeted - e.amtFilled
        }
        
        if totalIncomeToDeduct > self.callerVC.currentPeriod.income {
            let alert = UIAlertController(title: "Insufficient Income", message: "To fill the selected envelopes, first add more income.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            for e in self.selectedEnvelopes {
                e.amtFilled = e.amtBudgeted
            }
            self.callerVC.currentPeriod.income -= totalIncomeToDeduct
            self.tableView.reloadData()
            self.incomeLabel.text = String(self.callerVC.currentPeriod.income)
        }
    }
    
    /**
     * When the 'Fill Custom Amount' button is pressed, segues to CustomAmtView.
     */
    @IBAction func fillCustomAmount(_ sender: Any) {
        self.performSegue(withIdentifier: "toCustomAmtView", sender: sender)
    }
    
    /**
     * When the 'Done' button is pressed, segues back to PeriodView.
     */
    @IBAction func returnToPeriodVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /**
     * Method runs before segue:
     * if segue destination view controller is AddIncomeViewController or CustomAmtViewController,
     * sends reference to self (ManageIncomeViewController).
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination
        if type(of: destinationVC) == AddIncomeViewController.self {
            let destinationAddIncomeVC = destinationVC as! AddIncomeViewController
            destinationAddIncomeVC.callerVC = self
        }
        else if type(of: destinationVC) == CustomAmtViewController.self {
            let destinationCustomAmtVC = destinationVC as! CustomAmtViewController
            destinationCustomAmtVC.callerVC = self
        }
        
    }
    
    /**
     * Method runs after view has been loaded:
     * sets text of 'incomeLabel'.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.incomeLabel.text = String(self.callerVC.currentPeriod.income)
    }
    
    /**
     * Method runs right before view appears:
     * reloads the table view and the income label
     * (useful for when returning from other views,
     * where user may have changed some of the current period's properties).
     */
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.incomeLabel.text = String(self.callerVC.currentPeriod.income)
    }

}
