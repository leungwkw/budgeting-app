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
    
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 40
//    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.text = headerView.textLabel?.text?.uppercased()
//        headerView.textLabel?.font = UIFont(name: "Futura", size: 38)!
        // header.textLabel?.textColor = UIColor.lightGrayColor()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return currentPeriod?.envelopes.count ?? 0
        }
        else {
            return longTermEnvelopes?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EnvelopeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseableEnvelopeCell", for: indexPath) as! EnvelopeTableViewCell
        // Configure the cell’s contents.
        // cell.textLabel!.text = envelopes[indexPath.row].name
        let currentEnvelope: Envelope
        if indexPath.section == 0 {
            currentEnvelope = self.currentPeriod!.envelopes[indexPath.row]
        }
        else {
            currentEnvelope = self.longTermEnvelopes![indexPath.row]
        }
        cell.envelopNameLabel.text = currentEnvelope.name
        cell.spentLabel.text = "$" + String(currentEnvelope.amtSpent)
        cell.budgetedLabel.text = "$" + String(currentEnvelope.amtBudgeted)
        cell.spendingBar.value = CGFloat(currentEnvelope.amtSpent/currentEnvelope.amtBudgeted)
        return cell
    }
    
    var selectedEnvelope: Envelope?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedCell: EnvelopeTableViewCell = tableView.cellForRow(at: indexPath) as! EnvelopeTableViewCell
//        let selectedEnvelope = envelopes[indexPath.row]
//        selectedCell.spendingBar.animateValue(to: selectedCell.spendingBar.value + 0.1)
//        selectedEnvelope.amtSpent += 0.1
        
        if indexPath.section == 0 {
            selectedEnvelope = self.currentPeriod!.envelopes[indexPath.row]
        }
        else {
            selectedEnvelope = self.longTermEnvelopes![indexPath.row]
        }
        
        self.performSegue(withIdentifier: "showDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destinationVC: DetailsViewController = segue.destination as! DetailsViewController
        destinationVC.envelope = selectedEnvelope
        
    }
    
    let sectionHeaders = ["For This Period", "Long Term"]
    
//    let envelopes: [Envelope] = [
//        Envelope(name: "Groceries/Miscl", amtBudgeted: 100.00),
//        Envelope(name: "Recreation", amtBudgeted: 150.00),
//        Envelope(name: "Marriott Stay", amtBudgeted: 490.00),
//        Envelope(name: "Tithe", amtBudgeted: 220.00),
//        Envelope(name: "Savings", amtBudgeted: 400.00),
//        Envelope(name: "Investment", amtBudgeted: 100.00),
//
//    ]
//
//    let longTermEnvelopes: [Envelope] = [
//        Envelope(name: "Fall NOLA Trip", amtBudgeted: 100.00),
//        Envelope(name: "Sarah's iPad Case", amtBudgeted: 150.00),
//        Envelope(name: "Fall New York Trip", amtBudgeted: 490.00),
//        Envelope(name: "Housing Stipend Taxes", amtBudgeted: 220.00),
//        Envelope(name: "New Shoes", amtBudgeted: 400.00),
//        Envelope(name: "Baggage Fees", amtBudgeted: 100.00)
//    ]
    
    override func loadView() {
        super.loadView()
        
//        for e in self.envelopes {
//            let eView = EnvelopeView(envelope: e)
//            eView.heightAnchor.constraint(equalToConstant: 70).isActive = true
//            self.stackView.addArrangedSubview(eView)
//        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = self.currentPeriod?.name
        tableView.rowHeight = 90
        tableView.backgroundColor = UIColor.green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }


}

