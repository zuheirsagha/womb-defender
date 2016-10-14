//
//  CustomSegue.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-10-08.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let sourceVC = self.source
        let destinationVC = self.destination
        
        sourceVC.view.addSubview(destinationVC.view)

        
    }

}
