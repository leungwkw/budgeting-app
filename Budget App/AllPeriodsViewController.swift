//
//  BudgetingPeriodsViewController.swift
//  Budget App
//
//  Created by William Leung on 8/3/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class AllPeriodsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func createNewPeriod(_ sender: Any) {
        self.performSegue(withIdentifier: "toNewPeriodViewController", sender: sender)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.periods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "budgetingPeriodCell", for: indexPath)
        cell.textLabel?.text = self.periods[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPeriod = periods[indexPath.row]
        self.performSegue(withIdentifier: "toPeriodViewController", sender: indexPath)
    }
    
    var selectedPeriod: Period?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination
        if type(of: destinationVC) == PeriodViewController.self {
            let destinationPeriodVC = destinationVC as! PeriodViewController
            destinationPeriodVC.currentPeriod = selectedPeriod
            destinationPeriodVC.longTermEnvelopes = self.longTermEnvelopes
        }
    }
    
    var periods: [Period] = []
    
    let firstPeriodEnvelopes: [Envelope] = [
        Envelope(name: "Groceries/Miscl", amtBudgeted: 100.00),
        Envelope(name: "Recreation", amtBudgeted: 150.00),
        Envelope(name: "Marriott Stay", amtBudgeted: 490.00),
        Envelope(name: "Tithe", amtBudgeted: 220.00),
        Envelope(name: "Savings", amtBudgeted: 400.00),
        Envelope(name: "Investment", amtBudgeted: 100.00),
    ]
    
    let secondPeriodEnvelopes: [Envelope] = [
        Envelope(name: "Groceries/Miscl2", amtBudgeted: 100.00),
        Envelope(name: "Recreation2", amtBudgeted: 150.00),
        Envelope(name: "Marriott Stay2", amtBudgeted: 490.00),
        Envelope(name: "Tithe2", amtBudgeted: 220.00),
        Envelope(name: "Savings2", amtBudgeted: 400.00),
        Envelope(name: "Investment2", amtBudgeted: 100.00),
    ]
    
    let longTermEnvelopes: [Envelope] = [
        Envelope(name: "Fall NOLA Trip", amtBudgeted: 100.00),
        Envelope(name: "Sarah's iPad Case", amtBudgeted: 150.00),
        Envelope(name: "Fall New York Trip", amtBudgeted: 490.00),
        Envelope(name: "Housing Stipend Taxes", amtBudgeted: 220.00),
        Envelope(name: "New Shoes", amtBudgeted: 400.00),
        Envelope(name: "Baggage Fees", amtBudgeted: 100.00)
    ]
    
    override func loadView() {
        
        let firstPeriod = Period(name: "First Period", envelopes: self.firstPeriodEnvelopes)
        let secondPeriod = Period(name: "Second Period", envelopes: self.secondPeriodEnvelopes)
        self.periods.append(firstPeriod)
        self.periods.append(secondPeriod)
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Budgeting Periods"
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
