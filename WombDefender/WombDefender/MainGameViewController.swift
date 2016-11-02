//
//  MainGameViewController.swift
//  WombDefender
//
//  Created by Ehimare Okoyomon on 2016-10-05.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit
import SpriteKit

class MainGameViewController: UIViewController, LevelControllerDelegate, UICollisionBehaviorDelegate {
    @IBOutlet weak var _firstHeartImageView: UIImageView!
    @IBOutlet weak var _secondHeartImageView: UIImageView!
    @IBOutlet weak var _thirdHearImageView: UIImageView!
    @IBOutlet weak var _scoreLabel: UILabel!
    @IBOutlet weak var _settingsButton: UIButton!
    @IBAction func onSettingsButtonPressed(_ sender: UIButton) {
    }
    
    let lives = 3
    
    // Defaults to easy
    var currentLevelController: LevelController!
    
    var animator: UIDynamicAnimator!
    
    //Circles for egg and corresponding views (invisible but for collisiton)
    var centerLayerView: UIView!
    var secondLayerView: UIView!
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
        
        centerLayerView = UIView(frame: CGRect(
                                                x: view.frame.size.width/2 - CGFloat(view.frame.width/6),
                                                y: view.frame.size.height/2 - CGFloat(view.frame.width/6),
                                                width: CGFloat(view.frame.width/6)*2,
                                                height: CGFloat(view.frame.width/6)*2))
        centerLayerView.backgroundColor = UIColor.white
        centerLayerView.layer.cornerRadius = centerLayerView.frame.size.width/2
        self.view.addSubview(centerLayerView)
        
        secondLayerView = UIView(frame: CGRect(x: view.frame.size.width/2 - CGFloat(view.frame.width/5),
                                               y: view.frame.size.height/2 - CGFloat(view.frame.width/5),
                                               width: CGFloat(view.frame.width/5)*2,
                                               height: CGFloat(view.frame.width/5)*2))
        secondLayerView.center = CGPoint(x: view.frame.size.width  / 2, y: view.frame.size.height / 2)
        secondLayerView.backgroundColor = UIColor.white
        secondLayerView.alpha = 0.2
        secondLayerView.layer.cornerRadius = secondLayerView.frame.size.width/2
        self.view.addSubview(secondLayerView)
        
        thirdLayerView = UIView(frame: CGRect(x: view.frame.width/2 - CGFloat(view.frame.width/4.25),
                                              y: view.frame.height/2 - CGFloat(view.frame.width/4.25),
                                              width: CGFloat(view.frame.width/4.25)*2,
                                              height: CGFloat(view.frame.width/4.25)*2))
        thirdLayerView.center = CGPoint(x: view.frame.size.width  / 2, y: view.frame.size.height / 2)
        thirdLayerView.backgroundColor = UIColor.white
        thirdLayerView.alpha = 0.2
        thirdLayerView.layer.cornerRadius = thirdLayerView.frame.size.width/2
        self.view.addSubview(thirdLayerView)
        
        let outerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/4.25), startAngle: 0, endAngle: 2*3.14159, clockwise: true)
        let centerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/5), startAngle: 0, endAngle: 2*3.14159, clockwise: true)
        let innerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/6), startAngle: 0, endAngle: 2*3.14159, clockwise: true)

        if lives == 1{
            SpermBehaviour.collider.removeAllBoundaries()
            SpermBehaviour.collider.addBoundary(withIdentifier: "innerBarrier" as NSCopying, for: innerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _secondHeartImageView.image = #imageLiteral(resourceName: "heart_empty")
            _thirdHearImageView.image = #imageLiteral(resourceName: "heart_empty")
        } else if lives == 2 {
            SpermBehaviour.collider.removeAllBoundaries()
            SpermBehaviour.collider.addBoundary(withIdentifier: "centerBarrier" as NSCopying, for: centerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _secondHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _thirdHearImageView.image = #imageLiteral(resourceName: "heart_full")
        } else if lives == 3 {
            SpermBehaviour.collider.removeAllBoundaries()
            SpermBehaviour.collider.addBoundary(withIdentifier: "outerBarrier" as NSCopying, for: outerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _secondHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _thirdHearImageView.image = #imageLiteral(resourceName: "heart_full")
        } else {
            SpermBehaviour.collider.removeAllBoundaries()
            _firstHeartImageView.image = #imageLiteral(resourceName: "heart_empty")
            _secondHeartImageView.image = #imageLiteral(resourceName: "heart_empty")
            _thirdHearImageView.image = #imageLiteral(resourceName: "heart_empty")
        }
        
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
        x = Double(view.frame.midX+100)
        y = -10
        
        let sperm = SpermView(frame: CGRect(x: x, y: y, width: 20, height: 20))
        let swim = SpermBehaviour(x: sperm.frame.midX, y: sperm.frame.midY, centreX: self.view.frame.midX, centreY: self.view.frame.midY)
        swim.addItem(item: sperm)
        self.view.insertSubview(sperm, at: 1)
        animator.addBehavior(swim)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        if identifier as! String == "barrier" {
            let lives = LevelController.getLives(currentLevelController)
        }
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
