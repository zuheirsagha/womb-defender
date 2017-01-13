//
//  PowerUpCell.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2017-01-06.
//  Copyright © 2017 Zoko. All rights reserved.
//

import UIKit

protocol PowerUpCellDelegate {
    func boughtSomething()
}

class PowerUpCell : UITableViewCell {
    
    @IBOutlet weak var _powerUpNameLabel: UILabel!
    @IBOutlet weak var _powerUpImage: UIImageView!
    @IBOutlet weak var _powerUpDescriptionLabel: UILabel!
    @IBOutlet weak var _powerUpPriceButton: UIButton!
    
    private var _delegate : PowerUpCellDelegate!
    
    func setDelegate(_ powerUpCellDelegate:PowerUpCellDelegate){
        self._delegate = powerUpCellDelegate
    }
    
    var appDelegate : AppDelegate {
        get {
            return UIApplication.shared.delegate! as! AppDelegate
        }
    }
    
    @IBAction func onPowerUpPriceButtonPressed(_ sender: UIButton) {
        if _powerUpNameLabel.text == "Condom" && appDelegate.coins >= 100 {
            appDelegate.coins = appDelegate.coins - 100
            appDelegate.numberOfSecondPowerUps += 1
            _delegate.boughtSomething()
            print("Condom")
        }
        else if _powerUpNameLabel.text == "The Pill" && appDelegate.coins >= 100 {
            appDelegate.coins = appDelegate.coins - 100
            appDelegate.numberOfFirstPowerUps += 1
            _delegate.boughtSomething()
            print("The Pill")
        }
        else if _powerUpNameLabel.text == "Spermicide" && appDelegate.coins >= 100 {
            appDelegate.coins = appDelegate.coins - 100
            appDelegate.numberOfThirdPowerUps += 1
            _delegate.boughtSomething()
            print("Spermicide")
        }
    }
    
}
