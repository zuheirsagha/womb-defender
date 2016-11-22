//
//  SpermView.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-10-06.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit
import Foundation

class SpermView : UIView {
    
    private var _sperm : Sperm!
    
    public class func createSpermViewAt(x: Int, y: Int, size: SpermType, controller: LevelController, index: Int) -> SpermView {
        var view: SpermView!
        switch (size) {
        case .Regular:
            view = SpermView(frame: CGRect(x: x, y: y, width: 20, height: 20))
        case .Mega:
            view = SpermView(frame: CGRect(x: x, y: y, width: 40, height: 40))
        }
        view.layer.cornerRadius = 10
        view.setModel(type: size, controller: controller, index: index)
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setModel(type: SpermType, controller: LevelController, index: Int) {
        self._sperm = Sperm.createNewSperm(type: type, controller: controller, index: index)
    }
    
    public func spermJustHitBoundary() {
        _sperm.justHitBarrier()
    }
    
    public func isDead() -> Bool {
        return _sperm.isDead()
    }
    
    
    /** Attempts at rescaling from mega to normal are unsuccessful */
    public func resize() {
        switch (_sperm.size()) {
        case .Regular:
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: 20, height: 20)
//            self.bounds = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: 20, height: 20)
//            self.transform = .init(scaleX: 0.5, y: 0.5)
        case .Mega:
            return;
        }
        setNeedsDisplay()
//        self.superview!.bringSubview(toFront: self)
//        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
}
