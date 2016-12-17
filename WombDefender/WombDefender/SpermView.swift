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
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Initializer
    //
    /////////////////////////////////////////////////////////////////////////////////////

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Member Variables
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    private var _sperm : Sperm!
    
    public class func createSpermViewAt(x: Int, y: Int, size: SpermType, controller: LevelController, index: Int) -> SpermView {
        var view: SpermView!
        switch (size) {
        case .Regular:
            view = SpermView(frame: CGRect(x: x, y: y, width: 20, height: 20))
            view.layer.cornerRadius = 10
        case .Mega:
            view = SpermView(frame: CGRect(x: x, y: y, width: 40, height: 40))
            view.layer.cornerRadius = 20
        }
        
        view.setModel(type: size, controller: controller, index: index)
        return view
    }
    
    public func spermJustHitBoundary() {
        _sperm.justHitBarrier()
    }
    
    public func killSperm(index : Int) {
        _sperm.killSperm(index: index)
    }
    
    public func isDead() -> Bool {
        return _sperm.isDead()
    }
    
    public func resize() {
        switch (_sperm.size()) {
        case .Regular:
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: 20, height: 20)
            self.layer.cornerRadius = 10
        case .Mega:
            self.layer.cornerRadius = 20
            return;
        }
        setNeedsDisplay()
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Private Methods
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    fileprivate func setModel(type: SpermType, controller: LevelController, index: Int) {
        self._sperm = Sperm.createNewSperm(type: type, controller: controller, index: index)
    }
    
    
}
