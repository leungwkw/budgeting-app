//
//  PeriodViewController.swift
//  Budget App
//
//  Created by William Leung on 7/30/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class PeriodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var currentPeriod: Period!
    var longTermEnvelopes: [Envelope]!
    var selectedEnvelope: Envelope?
    
    let sectionHeaders = ["For This Period", "Long Term"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var unallocatedIncomeBtn: UIButton!
    
    /**
     * Informs table view of the number of sections in table.
     * Will always be 2 sections: the current period's envelopes and the long-term envelopes
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }
    
    /**
     * Informs table view of title of given section.
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
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
            return self.currentPeriod.envelopes.count
        }
        else {
            return self.longTermEnvelopes.count
        }
    }
    
    /**
     * Supplies table view with table cell for given section and row.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: EnvelopeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseableEnvelopeCell", for: indexPath) as! EnvelopeTableViewCell
        
        /*
         * Identifies envelope that should be used to populate the table cell we need to supply.
         */
        let currentEnvelope: Envelope
        if indexPath.section == 0 {
            currentEnvelope = self.currentPeriod.envelopes[indexPath.row]
        }
        else {
            currentEnvelope = self.longTermEnvelopes[indexPath.row]
        }
        
        /*
         * Sets properties of table cell according to 'currentEnvelope' properties.
         */
        cell.envelopNameLabel.text = currentEnvelope.name
        cell.spentLabel.text = String(currentEnvelope.amtSpent)
        cell.budgetedLabel.text = String(currentEnvelope.amtBudgeted)
        cell.filledSpentBar.filledValue = CGFloat(currentEnvelope.amtFilled/currentEnvelope.amtBudgeted)
        cell.filledSpentBar.spentValue = CGFloat(currentEnvelope.amtSpent/currentEnvelope.amtBudgeted)
        
        return cell
    }
    
    /**
     * Upon selecting a table cell, segues to EnvelopeDetailsView.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            self.selectedEnvelope = self.currentPeriod.envelopes[indexPath.row]
        }
        else {
            self.selectedEnvelope = self.longTermEnvelopes[indexPath.row]
        }
        
        self.performSegue(withIdentifier: "toEnvelopeDetailsView", sender: indexPath)
    }
    
    /**
     * When the '+' button is pressed, segues to NewEnvelopeView.
     */
    @IBAction func createNewEnvelope(_ sender: Any) {
        self.performSegue(withIdentifier: "toNewEnvelopeView", sender: sender)
    }
    
    /**
     * When the 'unallocatedIncomeBtn' is pressed, segues to ManageIncomeView.
     */
    @IBAction func manageIncome(_ sender: Any) {
        self.performSegue(withIdentifier: "toManageIncomeView", sender: sender)
    }
    
    /**
     * Method runs before segue:
     * if segue destination view controller is EnvelopeDetailsViewController,
     * sends the selected envelope to it before the segue;
     * if segue destination view controller is NewEnvelopeViewController or ManageIncomeViewController,
     * sends reference to self (Period View Controller).
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination
        if type(of: destinationVC) == EnvelopeDetailsViewController.self {
            let destinationEnvelopeDetailsVC = destinationVC as! EnvelopeDetailsViewController
            destinationEnvelopeDetailsVC.envelope = selectedEnvelope
        }
        else if type(of: destinationVC) == NewEnvelopeViewController.self {
            let destinationNewEnvelopeVC = destinationVC as! NewEnvelopeViewController
            destinationNewEnvelopeVC.callerVC = self
        }
        else if type(of: destinationVC) == ManageIncomeViewController.self {
            let destinationManageIncomeVC = destinationVC as! ManageIncomeViewController
            destinationManageIncomeVC.callerVC = self
        }
    }
    
    /**
     * Method runs after view has been loaded:
     * sets nav-bar title of this view, text of 'unallocatedIncomeBtn'
     * and some table view properties.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.currentPeriod.name
        self.unallocatedIncomeBtn.setTitle("Unallocated Income: " + String(self.currentPeriod.income), for: .normal)
        
        tableView.rowHeight = 90
        tableView.backgroundColor = UIColor.green
    }
    
    /**
     * Method runs right before view appears:
     * reloads the table view and text of unallocatedIncomeBtn
     * (useful for when returning from other views,
     * where user may have changed some properties of the current period).
     */
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.unallocatedIncomeBtn.setTitle("Unallocated Income: " + String(self.currentPeriod.income), for: .normal)
    }
}

