//
//  MainGameViewController.swift
//  WombDefender
//
//  Created by Ehimare Okoyomon on 2016-10-05.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController, LevelControllerDelegate {
    
    // Defaults to easy
    var currentLevelController: LevelController!

    override func viewDidLoad() {
        super.viewDidLoad()

        currentLevelController = Settings.getNewLevelControllerWithCurrentDifficulty(gameController: self)
        
        let gradient = GradientView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.insertSubview(gradient, at: 0)
        
        _drawWomb()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameIsOver() {
        // Do stuff
    }
    
    func removeSpermViewAtIndex(index: Int) {
        // Do stuff
    }
    
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
