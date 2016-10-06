//
//  StartScreenViewController.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-10-05.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    @IBOutlet weak var _headerView: UIView!
    @IBOutlet weak var _titleImageView: UIImageView!
    @IBOutlet weak var _tapToStartLabel: UILabel!
    @IBOutlet weak var _settingsButton: UIButton!
    @IBOutlet weak var _shoppingCartButton: UIButton!
    @IBOutlet weak var _standingsButton: UIButton!
    @IBOutlet weak var _tapToStartButton: UIButton!
    @IBOutlet weak var _backgroundView: UIView!
    
    /************************************************************************************
     *
     * LIFECYCLE METHODS
     *
     ***********************************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
//        let startColor = UIColor.red.cgColor
//        let endColor = UIColor.green.cgColor
//        let colors = [startColor, endColor]
//        UIGraphicsBeginImageContext(_backgroundView.frame.size)
//        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: [0, 1])
//        UIGraphicsGetCurrentContext()!.drawRadialGradient(gradient!, startCenter: _backgroundView.center, startRadius: 1, endCenter: _backgroundView.center, endRadius: 1, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //Do we need this?
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = .default
    }
    
    /************************************************************************************
     *
     * ACTIONS/SELECTORS
     *
     ***********************************************************************************/
    
    @IBAction func onTapToStartButtonClicked(_ sender: UIButton) {
    }
    @IBAction func onSettingsButtonClicked(_ sender: UIButton) {
    }
    @IBAction func onShoppingCartButtonClicked(_ sender: UIButton) {
    }
    @IBAction func onStandingsButtonClicked(_ sender: UIButton) {
    }
    
    /************************************************************************************
     *
     * PRIVATE METHODS
     *
     ***********************************************************************************/
    
}
