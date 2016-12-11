//
//  UIViewControllerExtension.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-12-10.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

extension UIViewController {
    var appDelegate : AppDelegate {
        get {
            return UIApplication.shared.delegate! as! AppDelegate
        }
    }
}
