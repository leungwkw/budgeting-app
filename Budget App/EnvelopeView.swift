//
//  EnvelopView.swift
//  Budget App
//
//  Created by William Leung on 7/30/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class EnvelopeView: UIView {
    
    public let envelope: Envelope
    public let envelopeLabel: UILabel
    public let filledLabel: UILabel
    public let spentLabel: UILabel
    public let budgetedLabel: UILabel
    public let fillingBar = FillingBar()
    public let spendingBar = SpendingBar()
    
    required init(envelope: Envelope) {
        self.envelope = envelope
        self.envelopeLabel = UILabel()
        self.filledLabel = UILabel()
        self.spentLabel = UILabel()
        self.budgetedLabel = UILabel()
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.envelope = Envelope(name: "some-envelope", amtBudgeted: 100.0)
        self.envelopeLabel = UILabel()
        self.filledLabel = UILabel()
        self.spentLabel = UILabel()
        self.budgetedLabel = UILabel()
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.envelopeLabel.text = String(self.envelope.name)
        self.filledLabel.text = String(self.envelope.amtFilled)
        self.spentLabel.text = String(self.envelope.amtSpent)
        self.budgetedLabel.text = String(self.envelope.amtBudgeted)
        
//        self.backgroundColor = UIColor(white: 0.6, alpha: 1)
        // self.fillingBar.backgroundColor = UIColor.green
        // self.spendingBar.backgroundColor = UIColor.blue
        self.addSubview(self.envelopeLabel)
        self.addSubview(self.fillingBar)
        self.addSubview(self.filledLabel)
        self.addSubview(self.budgetedLabel)
        
        // self.layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.fillingBar.frame = CGRect(x: 0, y: 3*self.bounds.height/4, width: self.bounds.width, height: self.bounds.height/4)
        self.spendingBar.frame = CGRect(x: 0, y: 3*self.bounds.height/4, width: self.bounds.width, height: self.bounds.height/4)
        
        self.envelopeLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height/2)
        self.filledLabel.frame = CGRect(x: 0, y: self.bounds.height/2, width: self.bounds.width/2, height: self.bounds.height/4)
        self.budgetedLabel.frame = CGRect(x: self.bounds.width/2, y: self.bounds.height/2, width: self.bounds.width/2, height: self.bounds.height/4)
        
        self.envelopeLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        self.budgetedLabel.textAlignment = .right
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        let margins = self.layoutMarginsGuide
        self.filledLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        self.filledLabel.topAnchor.constraint(equalTo: self.envelopeLabel.bottomAnchor).isActive = true
        self.budgetedLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.budgetedLabel.topAnchor.constraint(equalTo: self.envelopeLabel.bottomAnchor).isActive = true
    }

}
