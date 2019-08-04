//
//  ViewController.swift
//  Budget App
//
//  Created by William Leung on 7/30/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class PeriodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var currentPeriod: Period?
    var longTermEnvelopes: [Envelope]?
    var selectedEnvelope: Envelope?
    
    let sectionHeaders = ["For This Period", "Long Term"]
    
    @IBOutlet weak var tableView: UITableView!
    
    /**
     * Informs table view of the number of sections in table.
     * Will always be 2 sections: current period
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
            return currentPeriod?.envelopes.count ?? 0
        }
        else {
            return longTermEnvelopes?.count ?? 0
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
            currentEnvelope = self.currentPeriod!.envelopes[indexPath.row]
        }
        else {
            currentEnvelope = self.longTermEnvelopes![indexPath.row]
        }
        
        /*
         * Sets properties of table cell according to 'currentEnvelope' properties.
         */
        cell.envelopNameLabel.text = currentEnvelope.name
        cell.spentLabel.text = "$" + String(currentEnvelope.amtSpent)
        cell.budgetedLabel.text = "$" + String(currentEnvelope.amtBudgeted)
        cell.spendingBar.value = CGFloat(currentEnvelope.amtSpent/currentEnvelope.amtBudgeted)
        
        return cell
    }
    
    /**
     * Upon selecting a table cell, segues to EnvelopeDetailsViewController.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            selectedEnvelope = self.currentPeriod!.envelopes[indexPath.row]
        }
        else {
            selectedEnvelope = self.longTermEnvelopes![indexPath.row]
        }
        
        self.performSegue(withIdentifier: "toEnvelopeDetailsView", sender: indexPath)
    }
    
    /**
     * Method runs before segue:
     * if segue destination is EnvelopeDetailsViewController,
     * sends the selected envelope to it before the segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC: EnvelopeDetailsViewController = segue.destination as! EnvelopeDetailsViewController
        destinationVC.envelope = selectedEnvelope
        
    }
    
    /**
     * Method runs after view has been loaded:
     * sets nav-bar title of this view and some table view properties.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.currentPeriod?.name
        tableView.rowHeight = 90
        tableView.backgroundColor = UIColor.green
    }
    
    /**
     * Method runs right before view appears:
     * reloads the table view
     * (useful for when returning from Envelope-Details view,
     * where user may have changed some envelope properties).
     */
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}

