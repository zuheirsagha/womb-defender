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
    
    @IBOutlet weak var _endGameView: UIView!
    @IBOutlet weak var _endGameScoreLabel: UILabel!
    @IBOutlet weak var _endGameBestScoreLabel: UILabel!
    @IBOutlet var _swipeView: SwipeView!
    @IBOutlet weak var _endGameHomeButton: UIButton!
    @IBAction func onEndGameHomeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var _endGameRestartButton: UIButton!
    @IBAction func onEndGameRestartButtonPressed(_ sender: UIButton) {
        _startGame()
    }
    
    var KEY_SWIPE_IDENTIFIER = "swipe"
    
    // Defaults to easy
    var currentLevelController: LevelController!
    
    // Animation variables
    var animator: UIDynamicAnimator!
    var swim: SpermBehaviour!
    
    // Sperm Views Currently On Screen
    var sperms: [SpermView]!
    var total: Int = 0
    var interval: Int = 0
    
    fileprivate var _score : Int!
    
    // Circles for egg and corresponding views
    var centerLayerView: UIView!
    var secondLayerView: UIView!
    var thirdLayerView: UIView!
    
    /************************************************************************************
     *
     * LIFECYCLE METHODS
     *
     ***********************************************************************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = GradientView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.insertSubview(gradient, at: 0)
        
        _startGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameIsOver() {
        SpermBehaviour.collider.removeAllBoundaries()
        
        _swipeView.swipePath.removeAllPoints()
        _swipeView.setNeedsDisplay()
        
        _firstHeartImageView.image = #imageLiteral(resourceName: "heart_empty")
        _secondHeartImageView.image = #imageLiteral(resourceName: "heart_empty")
        _thirdHearImageView.image = #imageLiteral(resourceName: "heart_empty")
        
        centerLayerView.removeFromSuperview()
        
        for sperm in sperms {
            sperm.removeFromSuperview()
            swim.removeItem(item: sperm)
        }
        
        sperms.removeAll()
        total = 0
        interval = 0
        
        animator.removeAllBehaviors()
        
//        let playAgainAction = UIAlertAction(title: "Play Again", style: .default) { (action:UIAlertAction!) in
//            self._startGame()
//        }

        _endGameView.isHidden = false
    }
    
    func removeSpermViewAtIndex(index: Int) {
        // weird bug where this is still being called after all are dead.. my hack to fix it (put it off until later)
        // becuase I remove all sperm when game is over to otherwise it would be array out of bounds
        if (index < sperms.count) {
            sperms[index].removeFromSuperview()
        }
    }
    
    func demoteSpermViewAtIndex(index: Int) {
        // weird bug where this is still being called after all are dead.. my hack to fix it (put it off until later)
        // becuase I remove all sperm when game is over to otherwise it would be array out of bounds
        if (index < sperms.count) {
            sperms[index].resize()
        }
    }
    
    func removeSwimBehaviorAtIndex(index: Int) {
        if (index < sperms.count) {
            swim.removeItem(item: sperms[index])
        }
    }

    
    func reloadView() {
        _reloadViews()
    }
    
    /************************************************************************************
     *
     * ACTIONS/SELECTORS
     *
     ***********************************************************************************/
    
    @IBAction func onSettingsButtonPressed(_ sender: UIButton) {
        _hideShowSettings()
    }
    
    /************************************************************************************
     *
     * COLLISIONBEHAVIOUR DELEGATE
     *
     ***********************************************************************************/

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        if (identifier != nil) {
            let idAsString = identifier as! String
            if (idAsString == "outerBarrier" || idAsString == "centerBarrier" || idAsString == "innerBarrier") {
                if let item = item as? SpermView {
                    if !item.isDead() {
                        item.spermJustHitBoundary()
                        currentLevelController.spermHitEgg()
                    }
                    
                }
            }
            else if (idAsString == "swipe") {
                if let item = item as? SpermView {
                    if !item.isDead() {
                        item.spermJustHitBoundary()
                    }
                }
                _swipeView.swipePath.removeAllPoints()
                _swipeView.setNeedsDisplay()
                SpermBehaviour.collider.removeBoundary(withIdentifier: "swipe" as NSCopying)
                _reloadViews()
            }
        }
    }
    
    
    /************************************************************************************
     *
     * PRIVATE METHODS
     *
     ***********************************************************************************/
    
    // TODO: clean this up with instance variables or a file with constants or whatever.
    fileprivate func _reloadViews() {
        let outerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/4.25), startAngle: 0, endAngle: 2*3.14159, clockwise: true)
        let centerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/5), startAngle: 0, endAngle: 2*3.14159, clockwise: true)
        let innerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/6), startAngle: 0, endAngle: 2*3.14159, clockwise: true)
        
        let lives = currentLevelController.getLives()
        _score = currentLevelController.getScore()
        
        _scoreLabel.text = "\(_score!)"
        
        if lives == 3 {
            SpermBehaviour.collider.removeBoundary(withIdentifier: "outerBarrier" as NSCopying)
            SpermBehaviour.collider.addBoundary(withIdentifier: "outerBarrier" as NSCopying, for: outerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _secondHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _thirdHearImageView.image = #imageLiteral(resourceName: "heart_full")
            
            self.view.addSubview(centerLayerView)
            self.view.addSubview(secondLayerView)
            self.view.addSubview(thirdLayerView)
        } else if lives == 2 {
            SpermBehaviour.collider.removeBoundary(withIdentifier: "outerBarrier" as NSCopying)
            SpermBehaviour.collider.addBoundary(withIdentifier: "centerBarrier" as NSCopying, for: centerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _secondHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _thirdHearImageView.image = #imageLiteral(resourceName: "heart_empty")
            
            thirdLayerView.removeFromSuperview()
        } else if lives == 1 {
            SpermBehaviour.collider.removeBoundary(withIdentifier: "centerBarrier" as NSCopying)
            SpermBehaviour.collider.addBoundary(withIdentifier: "innerBarrier" as NSCopying, for: innerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _secondHeartImageView.image = #imageLiteral(resourceName: "heart_empty")
            _thirdHearImageView.image = #imageLiteral(resourceName: "heart_empty")
            
            secondLayerView.removeFromSuperview()
        }
    }
    
    fileprivate func _drawWomb() {
        centerLayerView = UIView(frame: CGRect(
            x: view.frame.size.width/2 - CGFloat(view.frame.width/6),
            y: view.frame.size.height/2 - CGFloat(view.frame.width/6),
            width: CGFloat(view.frame.width/6)*2,
            height: CGFloat(view.frame.width/6)*2))
        centerLayerView.backgroundColor = UIColor.white
        centerLayerView.layer.cornerRadius = centerLayerView.frame.size.width/2
        
        secondLayerView = UIView(frame: CGRect(x: view.frame.size.width/2 - CGFloat(view.frame.width/5),
                                               y: view.frame.size.height/2 - CGFloat(view.frame.width/5),
                                               width: CGFloat(view.frame.width/5)*2,
                                               height: CGFloat(view.frame.width/5)*2))
        secondLayerView.center = CGPoint(x: view.frame.size.width  / 2, y: view.frame.size.height / 2)
        secondLayerView.backgroundColor = UIColor.white
        secondLayerView.alpha = 0.2
        secondLayerView.layer.cornerRadius = secondLayerView.frame.size.width/2
        
        thirdLayerView = UIView(frame: CGRect(x: view.frame.width/2 - CGFloat(view.frame.width/4.25),
                                              y: view.frame.height/2 - CGFloat(view.frame.width/4.25),
                                              width: CGFloat(view.frame.width/4.25)*2,
                                              height: CGFloat(view.frame.width/4.25)*2))
        thirdLayerView.center = CGPoint(x: view.frame.size.width  / 2, y: view.frame.size.height / 2)
        thirdLayerView.backgroundColor = UIColor.white
        thirdLayerView.alpha = 0.2
        thirdLayerView.layer.cornerRadius = thirdLayerView.frame.size.width/2
    }
    
    func _startGame() {
        _endGameView.isHidden = true

        animator = UIDynamicAnimator(referenceView: self.view)

        currentLevelController = Settings.getNewLevelControllerWithCurrentDifficulty(gameController: self)
        currentLevelController.restart()
        sperms = [SpermView]()
        
        swim = SpermBehaviour(centreX: self.view.frame.midX, centreY: self.view.frame.midY)
        
        SpermBehaviour.collider.collisionDelegate = self
        total = currentLevelController.numberOfSperm()
        interval = currentLevelController.interval()
        swim.setFieldStrength(strength: currentLevelController.fieldStrength())
        
        _drawWomb()
        _reloadViews()
        createSperm()
        animator.addBehavior(swim)
    }
    
    private func createSperm() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(interval)) {
            self._createSperm()
            self.total -= 1
            if (self.total > 0) {
                self.createSperm()
            }
        }
    }
    
    fileprivate func _createSperm() {
        
        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        
        let randomX = arc4random_uniform(UInt32(screenWidth))
        let randomY = arc4random_uniform(UInt32(screenWidth))
        
        var x = 0
        var y = 0
        
        let randomDirection = arc4random_uniform(4)
        switch randomDirection {
        case 0:
            x = Int(randomX)
            y = -30
        case 1:
            x = Int(screenWidth) + 30
            y = Int(randomY)
        case 2:
            x = Int(randomX)
            y = Int(screenHeight)+30
        case 3:
            x = -30
            y = Int(randomY)
        default:
            x = 0
            y = 0
        }
        let count = sperms.count
        let sperm = SpermView.createSpermViewAt(x: x, y: y, size: .Mega, controller: currentLevelController, index: count)
        self.view.insertSubview(sperm, at: 1)
        sperms.insert(sperm, at: count)

        swim.addItem(item: sperm)
    }
    
    fileprivate func _hideShowSettings() {
        
        if animator.behaviors.count > 0 {
            animator.removeAllBehaviors()
            
            if self.currentLevelController.getLives() == 2 {
                self.thirdLayerView.alpha = 0
                self.view.addSubview(self.thirdLayerView)
            } else if self.currentLevelController.getLives() == 1 {
                self.thirdLayerView.alpha = 0
                self.secondLayerView.alpha = 0
                self.view.addSubview(self.thirdLayerView)
                self.view.addSubview(self.secondLayerView)
            }
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                if self.currentLevelController.getLives() == 2 {
                    self.thirdLayerView.alpha = 0.2
                } else if self.currentLevelController.getLives() == 1 {
                    self.thirdLayerView.alpha = 0.2
                    self.secondLayerView.alpha = 0.2
                }
                self.centerLayerView.transform = CGAffineTransform(scaleX: 3.25, y: 3.25)
                self.secondLayerView.transform = CGAffineTransform(scaleX: 3.25, y: 3.25)
                self.thirdLayerView.transform = CGAffineTransform(scaleX: 3.25, y: 3.25)
            })
            
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                
                if self.currentLevelController.getLives() == 2 {
                    self.thirdLayerView.alpha = 0
                } else if self.currentLevelController.getLives() == 1 {
                    self.thirdLayerView.alpha = 0
                    self.secondLayerView.alpha = 0
                }
                self.centerLayerView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.secondLayerView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.thirdLayerView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: { (Bool) in
                    if self.currentLevelController.getLives() == 2 {
                        self.thirdLayerView.removeFromSuperview()
                    } else if self.currentLevelController.getLives() == 1 {
                        self.thirdLayerView.removeFromSuperview()
                        self.secondLayerView.removeFromSuperview()
                    }
                    self.animator.addBehavior(self.swim)
            })
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
