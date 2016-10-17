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
    
    var animator: UIDynamicAnimator!
    
    //Circles for egg and corresponding views (invisible but for collisiton)
    var centerLayer: CAShapeLayer!
    var centerLayerView: UIView!
    var secondLayer: CAShapeLayer!
    var secondLayerView: UIView!
    var thirdLayer: CAShapeLayer!
    var thirdLayerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        currentLevelController = Settings.getNewLevelControllerWithCurrentDifficulty(gameController: self)
        
        let gradient = GradientView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.insertSubview(gradient, at: 0)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        _drawWomb()
        startGame()
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
    
    // Will clean this up with instance variables or a file with constants or whatever.
    // They stacked onto each other if added all 3 to uidynamicbehaviour so just added outside.
    // Theoretically we only ever need the outermost one anyway.
    fileprivate func _drawWomb() {
        
        let centreCircle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/6), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        centerLayer = CAShapeLayer()
        centerLayer.path = centreCircle.cgPath
        centerLayer.fillColor = UIColor.white.cgColor
        centerLayer.strokeColor = UIColor.clear.cgColor
        centerLayer.lineWidth = 3.0
        view.layer.addSublayer(centerLayer)
//        centerLayerView = UIView(frame: CGRect(x: view.center.x - CGFloat(view.frame.width/6), y: view.center.y - CGFloat(view.frame.width/6), width: CGFloat(view.frame.width/6)*2, height: CGFloat(view.frame.width/6)*2))
//        SpermBehaviour.collider.addItem(centerLayerView)
//        centerLayerView.backgroundColor = UIColor.green
//        self.view.addSubview(centerLayerView)
        
        let layer2Circle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/5), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        secondLayer = CAShapeLayer()
        secondLayer.path = layer2Circle.cgPath
        secondLayer.fillColor = UIColor.white.cgColor
        secondLayer.strokeColor = UIColor.clear.cgColor
        secondLayer.lineWidth = 3.0
        secondLayer.opacity = 0.2
        view.layer.addSublayer(secondLayer)
//        secondLayerView = UIView(frame: CGRect(x: view.center.x - CGFloat(view.frame.width/5), y: view.center.y - CGFloat(view.frame.width/5), width: CGFloat(view.frame.width/5)*2, height: CGFloat(view.frame.width/5)*2))
//        SpermBehaviour.collider.addItem(secondLayerView)
//        secondLayerView.backgroundColor = UIColor.green
//        self.view.addSubview(secondLayerView)
        
        let layer3Circle = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/4.25), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        thirdLayer = CAShapeLayer()
        thirdLayer.path = layer3Circle.cgPath
        thirdLayer.fillColor = UIColor.white.cgColor
        thirdLayer.strokeColor = UIColor.clear.cgColor
        thirdLayer.lineWidth = 3.0
        thirdLayer.opacity = 0.2
        view.layer.addSublayer(thirdLayer)
        thirdLayerView = UIView(frame: CGRect(x: view.center.x - CGFloat(view.frame.width/4.25), y: view.center.y - CGFloat(view.frame.width/4.25), width: CGFloat(view.frame.width/4.25)*2, height: CGFloat(view.frame.width/4.25)*2))
        SpermBehaviour.collider.addItem(thirdLayerView)
        thirdLayerView.backgroundColor = UIColor.green
        thirdLayerView.layer.cornerRadius = thirdLayerView.frame.size.width/2
        self.view.addSubview(thirdLayerView)
    }

    func startGame() {
        var x = 0.0
        var y = 0.0
        let xOrY = arc4random_uniform(2)
        let leftOrRight = arc4random_uniform(2)
        if xOrY == 1 {
            if leftOrRight == 1 {
                x = -10
            } else {
                x = Double(view.frame.width)-10
            }
            y = Double(arc4random_uniform(UInt32(view.frame.height)))
        } else {
            if leftOrRight == 1 {
                y = -10
            } else {
                y = Double(view.frame.height)-10
            }
            x = Double(arc4random_uniform(UInt32(view.frame.width)))
        }
        
        let sperm = SpermView(frame: CGRect(x: x, y: y, width: 20, height: 20))
        let swim = SpermBehaviour(x: sperm.frame.midX, y: sperm.frame.midY, centreX: self.view.frame.midX, centreY: self.view.frame.midY)
        swim.addItem(item: sperm)
        self.view.insertSubview(sperm, at: 1)
        animator.addBehavior(swim)
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
