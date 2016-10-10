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
    
    fileprivate var settingsPressed = false
    
    fileprivate var secondLayer: CAShapeLayer!
    fileprivate var layer2Circle: UIBezierPath!

    fileprivate var thirdLayer: CAShapeLayer!
    fileprivate var layer3Circle: UIBezierPath!
    
    fileprivate var centerLayer: CAShapeLayer!
    fileprivate var centreCircle: UIBezierPath!
    
    /************************************************************************************
     *
     * LIFECYCLE METHODS
     *
     ***********************************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = GradientView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.insertSubview(gradient, at: 0)
       
        //_drawWomb()
        
        layer2Circle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/5), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        secondLayer = CAShapeLayer()
        secondLayer.path = layer2Circle.cgPath
        secondLayer.fillColor = UIColor.white.cgColor
        secondLayer.opacity = 0.2
        view.layer.addSublayer(secondLayer)
        
        layer3Circle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/4.25), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        thirdLayer = CAShapeLayer()
        thirdLayer.path = layer3Circle.cgPath
        thirdLayer.fillColor = UIColor.white.cgColor
        thirdLayer.opacity = 0.2
        view.layer.addSublayer(thirdLayer)
        
        centreCircle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/6), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        centerLayer = CAShapeLayer()
        centerLayer.path = centreCircle.cgPath
        centerLayer.fillColor = UIColor.white.cgColor
        view.layer.addSublayer(centerLayer)
        
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
        self.performSegue(withIdentifier: "segueToMainGameViewController", sender: self)
    }
    @IBAction func onSettingsButtonClicked(_ sender: UIButton) {
        
        let scaleFactor = CGFloat(2)
        var affineTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        
        let transformedPathThird = self.layer3Circle.cgPath.copy(using: &affineTransform)
        self.thirdLayer.path = transformedPathThird
        
        let transformedPathSecond = self.layer2Circle.cgPath.copy(using: &affineTransform)
        self.secondLayer.path = transformedPathSecond
        
        let transformedPath = self.centreCircle.cgPath.copy(using: &affineTransform)
        self.centerLayer.path = transformedPath
        
        //_drawWomb()
        
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
        
        let layer2Circle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/5), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let secondLayer = CAShapeLayer()
        secondLayer.path = layer2Circle.cgPath
        secondLayer.fillColor = UIColor.white.cgColor
        secondLayer.opacity = 0.2
        view.layer.addSublayer(secondLayer)
        
        let layer3Circle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/4.25), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let thirdLayer = CAShapeLayer()
        thirdLayer.path = layer3Circle.cgPath
        thirdLayer.fillColor = UIColor.white.cgColor
        thirdLayer.opacity = 0.2
        view.layer.addSublayer(thirdLayer)
        
        let centreCircle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/6), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let centerLayer = CAShapeLayer()
        centerLayer.path = centreCircle.cgPath
        centerLayer.fillColor = UIColor.white.cgColor
        view.layer.addSublayer(centerLayer)
        
        if settingsPressed {
            // TODO: Animate the womb enlarging -> use this as settings menu
            let scaleFactor = centerLayer.frame.width*0/centerLayer.frame.height + 2
            
            var affineTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            let transformedPath = centreCircle.cgPath.copy(using: &affineTransform)
            centerLayer.path = transformedPath
        }
    }
    
}
