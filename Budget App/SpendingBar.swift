//
//  SpendingBar.swift
//  Budget App
//
//  Created by William Leung on 7/30/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class SpendingBar: UIView {

    public var color: UIColor = .blue { didSet { self.valueView.backgroundColor = color }}
    public var value: CGFloat {
        get { return self._value }
        set(newValue) { self._value = newValue; self.update(toAnimate: false) }
    }
    private var _value: CGFloat = 0.7
    
    private let valueView = UIView()
    private var valueFrame: CGRect {
        var widthFraction = self._value
        if widthFraction < 0 { widthFraction = 0 }
        if widthFraction > 1 { widthFraction = 1 }
        return CGRect(x: 0, y: 0, width: widthFraction * self.bounds.width, height: self.bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.valueView.backgroundColor = color
        self.addSubview(self.valueView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.valueView.frame = self.valueFrame
    }
    
    public func animateValue(to newValue: CGFloat) {
        self._value = newValue
        // self.color = self.modelValue > 0.2 ? .black : .red
        self.update(toAnimate: true)
    }
    
    private func update(toAnimate: Bool) {
        if toAnimate {
            UIView.animate(withDuration: 0.5, animations: {
                self.valueView.frame = self.valueFrame
            })
        } else {
            self.valueView.frame = self.valueFrame
        }
    }

}
