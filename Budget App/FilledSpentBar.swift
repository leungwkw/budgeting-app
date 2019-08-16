//
//  FilledSpentBar.swift
//  Budget App
//
//  Created by William Leung on 7/30/19.
//  Copyright © 2019 William Leung. All rights reserved.
//

import UIKit

class FilledSpentBar: UIView {
    
    /**
     * Colors for the 'filledBar' and 'spentBar'.
     */
    let fillingColor = UIColor.green
    let spendingColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
    
    private var _filledValue: CGFloat = 0
    private var _spentValue: CGFloat = 0
    
    private let filledBar = UIView()
    private let spentBar = UIView()
    
    /**
     * Public accessors for '_filledValue' and '_spentValue' respectively;
     * setting values through these accessors will not trigger animations.
     */
    var filledValue: CGFloat {
        get {
            return self._filledValue
        }
        set(newValue) {
            self._filledValue = newValue
            self.updateFilledBar(toAnimate: false)
        }
    }
    var spentValue: CGFloat {
        get {
            return self._spentValue
        }
        set(newValue) {
            self._spentValue = newValue
            self.updateSpentBar(toAnimate: false)
        }
    }
    
    /**
     * Computed properties: the CG-frames for 'filledBar' and 'spentBar',
     * as determined by '_filledValue' and '_spentValue' respectively.
     */
    private var filledBarFrame: CGRect {
        var widthFraction = self._filledValue
        if widthFraction < 0 { widthFraction = 0 }
        if widthFraction > 1 { widthFraction = 1 }
        return CGRect(x: 0, y: 0, width: widthFraction * self.bounds.width, height: self.bounds.height)
    }
    private var spentBarFrame: CGRect {
        var widthFraction = self._spentValue
        if widthFraction < 0 { widthFraction = 0 }
        if widthFraction > 1 { widthFraction = 1 }
        return CGRect(x: 0, y: 0, width: widthFraction * self.bounds.width, height: self.bounds.height)
    }
    
    /**
     * Initializers that all call the setup() function defined below.
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    /**
     * Method is called when the view is initialized:
     * sets all the relevant background colors and the border properties;
     * also adds the 'filledBar' and 'spentBar' to the view.
     */
    private func setup() {
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1
        self.layer.borderColor = (UIColor(white: 0.8, alpha: 1)).cgColor
        self.filledBar.backgroundColor = self.fillingColor
        self.spentBar.backgroundColor = self.spendingColor
        self.addSubview(self.filledBar)
        self.addSubview(self.spentBar)
    }
    
    /**
     * Assigns the 'filledBar' and 'spentBar' their frames.
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.filledBar.frame = self.filledBarFrame
        self.spentBar.frame = self.spentBarFrame
    }
    
    /**
     * Public methods for animating the 'filledBar' or 'spentBar' to specified levels.
     */
    public func animateFilledValue(to newValue: CGFloat) {
        self._filledValue = newValue
        self.updateFilledBar(toAnimate: true)
    }
    public func animateSpentValue(to newValue: CGFloat) {
        self._spentValue = newValue
        self.updateSpentBar(toAnimate: true)
    }
    
    /**
     * Private methods for updating the 'filledBar' or 'spentBar' to
     * whatever the new 'filledBarFrame' or 'spentBarFrame' is, respectively;
     * gives a choice of whether or not to animate the update.
     */
    private func updateFilledBar(toAnimate: Bool) {
        if toAnimate {
            UIView.animate(withDuration: 0.5, animations: {
                self.filledBar.frame = self.filledBarFrame
            })
        } else {
            self.filledBar.frame = self.filledBarFrame
        }
    }
    private func updateSpentBar(toAnimate: Bool) {
        if toAnimate {
            UIView.animate(withDuration: 0.5, animations: {
                self.spentBar.frame = self.spentBarFrame
            })
        } else {
            self.spentBar.frame = self.spentBarFrame
        }
    }

}
