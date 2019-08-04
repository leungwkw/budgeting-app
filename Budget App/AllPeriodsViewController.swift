//
//  BudgetingPeriodsViewController.swift
//  Budget App
//
//  Created by William Leung on 8/3/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class AllPeriodsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var periods: [Period] = []
    var selectedPeriod: Period?
    
    /**
     * Informs table view of the number of rows in given section.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.periods.count
    }
    
    /**
     * Supplies table view with table cell for given section and row.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseablePeriodCell", for: indexPath)
        cell.textLabel?.text = self.periods[indexPath.row].name
        return cell
    }
    
    /**
     * Upon selecting a table cell, segues to PeriodViewController.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPeriod = periods[indexPath.row]
        self.performSegue(withIdentifier: "toPeriodView", sender: indexPath)
    }
    
    /**
     * When the 'New' button is pressed, segues to NewPeriodViewController.
     */
    @IBAction func createNewPeriod(_ sender: Any) {
        self.performSegue(withIdentifier: "toNewPeriodView", sender: sender)
    }
    
    /**
     * Method runs before segue:
     * if segue destination is PeriodViewController,
     * sends the selected period and long-term envelopes to it before the segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination
        if type(of: destinationVC) == PeriodViewController.self {
            let destinationPeriodVC = destinationVC as! PeriodViewController
            destinationPeriodVC.currentPeriod = selectedPeriod
            destinationPeriodVC.longTermEnvelopes = self.longTermEnvelopes
        }
    }
    
    /**
     * Method runs before loading the view:
     * Populates 'periods' array from dummy data.
     */
    override func loadView() {
        let firstPeriod = Period(name: "First Period", envelopes: self.firstPeriodEnvelopes)
        let secondPeriod = Period(name: "Second Period", envelopes: self.secondPeriodEnvelopes)
        self.periods.append(firstPeriod)
        self.periods.append(secondPeriod)
        super.loadView()
    }
    
    /**
     * Method runs after view has been loaded:
     * Sets nav-bar title of this view.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Budgeting Periods"
    }
    
    /**
     * DUMMY DATA: envelopes for first period.
     */
    let firstPeriodEnvelopes: [Envelope] = [
        Envelope(name: "Groceries/Miscl", amtBudgeted: 100.00),
        Envelope(name: "Recreation", amtBudgeted: 150.00),
        Envelope(name: "Marriott Stay", amtBudgeted: 490.00),
        Envelope(name: "Tithe", amtBudgeted: 220.00),
        Envelope(name: "Savings", amtBudgeted: 400.00),
        Envelope(name: "Investment", amtBudgeted: 100.00),
    ]
    
    /**
     * DUMMY DATA: envelopes for second period.
     */
    let secondPeriodEnvelopes: [Envelope] = [
        Envelope(name: "Groceries/Miscl2", amtBudgeted: 100.00),
        Envelope(name: "Recreation2", amtBudgeted: 150.00),
        Envelope(name: "Marriott Stay2", amtBudgeted: 490.00),
        Envelope(name: "Tithe2", amtBudgeted: 220.00),
        Envelope(name: "Savings2", amtBudgeted: 400.00),
        Envelope(name: "Investment2", amtBudgeted: 100.00),
    ]
    
    /**
     * DUMMY DATA: long-term envelopes.
     */
    let longTermEnvelopes: [Envelope] = [
        Envelope(name: "Fall NOLA Trip", amtBudgeted: 100.00),
        Envelope(name: "Sarah's iPad Case", amtBudgeted: 150.00),
        Envelope(name: "Fall New York Trip", amtBudgeted: 490.00),
        Envelope(name: "Housing Stipend Taxes", amtBudgeted: 220.00),
        Envelope(name: "New Shoes", amtBudgeted: 400.00),
        Envelope(name: "Baggage Fees", amtBudgeted: 100.00)
    ]
}
