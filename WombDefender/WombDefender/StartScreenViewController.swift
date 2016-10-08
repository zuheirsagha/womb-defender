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
        UIApplication.shared.isStatusBarHidden = true
        
        let gradient = GradientView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.insertSubview(gradient, at: 0)
        _drawWomb()
        
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
    
    fileprivate func _drawWomb() {
        
        let centreCircle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/6), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let centerLayer = CAShapeLayer()
        centerLayer.path = centreCircle.cgPath
        centerLayer.fillColor = UIColor.white.cgColor
        centerLayer.strokeColor = UIColor.clear.cgColor
        centerLayer.lineWidth = 3.0
        view.layer.addSublayer(centerLayer)
        
        let layer2Circle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/5), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let secondLayer = CAShapeLayer()
        secondLayer.path = layer2Circle.cgPath
        secondLayer.fillColor = UIColor.white.cgColor
        secondLayer.strokeColor = UIColor.clear.cgColor
        secondLayer.lineWidth = 3.0
        secondLayer.opacity = 0.2
        view.layer.addSublayer(secondLayer)
        
        let layer3Circle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/4.25), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let thirdLayer = CAShapeLayer()
        thirdLayer.path = layer3Circle.cgPath
        thirdLayer.fillColor = UIColor.white.cgColor
        thirdLayer.strokeColor = UIColor.clear.cgColor
        thirdLayer.lineWidth = 3.0
        thirdLayer.opacity = 0.2
        view.layer.addSublayer(thirdLayer)
    }
    
}
