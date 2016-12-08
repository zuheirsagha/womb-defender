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
    @IBOutlet weak var _endGameRestartButton: UIButton!
    @IBOutlet weak var _endGameHomeButton: UIButton!

    @IBOutlet var _swipeView: SwipeView!
    
    @IBOutlet weak var _levelBanner: UIView!
    @IBOutlet weak var _levelBannerLabel: UILabel!
    
    var KEY_SWIPE_IDENTIFIER = "swipe"
    var KEY_OUTER_BARRIER = "outerBarrier"
    var KEY_CENTER_BARRIER = "centerBarrier"
    var KEY_INNER_BARRIER = "innerBarrier"
    
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
        
        _levelBanner.isHidden = true
        
        _startGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /************************************************************************************
     *
     * ACTIONS/SELECTORS
     *
     ***********************************************************************************/
    
    @IBAction func onSettingsButtonPressed(_ sender: UIButton) {
        _hideShowSettings()
    }
    
    @IBAction func onEndGameHomeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onEndGameRestartButtonPressed(_ sender: UIButton) {
        _startGame()
    }
    
    /************************************************************************************
     *
     * LEVEL CONTROLLER DELEGATE METHODS
     *
     ***********************************************************************************/

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
        
        _endGameView.alpha = 0.0
        _endGameView.isHidden = false
        _endGameScoreLabel.text = "\(_score!)"
        UIView.transition(with: _endGameView, duration: 0.5, options: UIViewAnimationOptions.allowAnimatedContent, animations: {self._endGameView.alpha=1.0}, completion: nil)
    }
    
    func nextLevel() {
        total = currentLevelController.numberOfSperm
        _levelBannerLabel.text = "Level \(currentLevelController.level!)"
        _levelBanner.alpha = 0
        if currentLevelController.getLives() != 0 {
            self._levelBanner.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self._levelBanner.alpha = 1
            }, completion: { (Bool) in
                UIView.animate(withDuration: 0.5, animations: {
                    self._levelBanner.alpha = 0
                }, completion: { (Bool) in
                    self._levelBanner.isHidden = true
                    self.createSperm()
                })
            })
        }
        //TODO: Screws with lives when starting again / makes boundaries act weird
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
     * COLLISIONBEHAVIOUR DELEGATE
     *
     ***********************************************************************************/

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        if (identifier != nil) {
            let idAsString = identifier as! String
            if (idAsString == KEY_OUTER_BARRIER || idAsString == KEY_CENTER_BARRIER || idAsString == KEY_INNER_BARRIER) {
                if let item = item as? SpermView {
                    item.spermJustHitBoundary()
                    currentLevelController.spermHitEgg()
                }
            }
            else if (idAsString == KEY_SWIPE_IDENTIFIER) {
                if let item = item as? SpermView {
                    item.spermJustHitBoundary()
                }
                _swipeView.swipePath.removeAllPoints()
                _swipeView.setNeedsDisplay()
                SpermBehaviour.collider.removeBoundary(withIdentifier: KEY_SWIPE_IDENTIFIER as NSCopying)
                _reloadViews()
            }
        }
    }
    
    /************************************************************************************
     *
     * PRIVATE METHODS
     *
     ***********************************************************************************/
    
    fileprivate func _reloadViews() {
        let outerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/4.25), startAngle: 0, endAngle: 2*3.14159, clockwise: true)
        let centerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/5), startAngle: 0, endAngle: 2*3.14159, clockwise: true)
        let innerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/6), startAngle: 0, endAngle: 2*3.14159, clockwise: true)
        
        let lives = currentLevelController.getLives()
        _score = currentLevelController.getScore()
        
        _scoreLabel.text = "\(_score!)"
        
        if lives == 3 {
            SpermBehaviour.collider.removeBoundary(withIdentifier: KEY_OUTER_BARRIER as NSCopying)
            SpermBehaviour.collider.addBoundary(withIdentifier: KEY_OUTER_BARRIER as NSCopying, for: outerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _secondHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _thirdHearImageView.image = #imageLiteral(resourceName: "heart_full")
            
            self.view.addSubview(centerLayerView)
            self.view.addSubview(secondLayerView)
            self.view.addSubview(thirdLayerView)
        } else if lives == 2 {
            SpermBehaviour.collider.removeBoundary(withIdentifier: KEY_OUTER_BARRIER as NSCopying)
            SpermBehaviour.collider.addBoundary(withIdentifier: KEY_CENTER_BARRIER as NSCopying, for: centerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _secondHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _thirdHearImageView.image = #imageLiteral(resourceName: "heart_empty")
            
            thirdLayerView.removeFromSuperview()
        } else if lives == 1 {
            SpermBehaviour.collider.removeBoundary(withIdentifier: KEY_CENTER_BARRIER as NSCopying)
            SpermBehaviour.collider.addBoundary(withIdentifier: KEY_INNER_BARRIER as NSCopying, for: innerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "heart_full")
            _secondHeartImageView.image = #imageLiteral(resourceName: "heart_empty")
            _thirdHearImageView.image = #imageLiteral(resourceName: "heart_empty")
            
            secondLayerView.removeFromSuperview()
        }
    }
    
    fileprivate func _drawWomb() {
        let views = UIHelper.drawWomb(view.frame.width, height: view.frame.height)
        centerLayerView = views[0]
        secondLayerView = views[1]
        thirdLayerView = views[2]
    }
    
    fileprivate func _startGame() {
        _endGameView.isHidden = true

        animator = UIDynamicAnimator(referenceView: self.view)
        
        currentLevelController = Settings.getNewLevelControllerWithCurrentDifficulty(gameController: self)
        currentLevelController.restart()
        sperms = [SpermView]()
        
        swim = SpermBehaviour(centreX: self.view.frame.midX, centreY: self.view.frame.midY)
        
        SpermBehaviour.collider.collisionDelegate = self
        total = currentLevelController.numberOfSperm
        interval = currentLevelController.interval()
        swim.setFieldStrength(strength: currentLevelController.fieldStrength())
        
        _drawWomb()
        _reloadViews()
        createSperm()
        animator.addBehavior(swim)
    }
    
    fileprivate func createSperm() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(interval)) {
            for _ in 0..<self.total {
                self._createSperm()
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
        
        let spermType : SpermType!
        let rand = arc4random_uniform(100)
        print("\(UInt32(currentLevelController.probabilityOfMega)) rand \(rand)")
        if rand <= UInt32(currentLevelController.probabilityOfMega!) {
            spermType = SpermType.Mega
        }
        else {
            spermType = SpermType.Regular
        }
        
        let sperm = SpermView.createSpermViewAt(x: x, y: y, size: spermType, controller: currentLevelController, index: count)
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
            
            UIHelper.resizeEgg(true, centerLayer: centerLayerView, secondLayer: secondLayerView, thirdLayer: thirdLayerView)
        } else {
            
            let delay = DispatchTime.now() + DispatchTimeInterval.milliseconds(500)
            DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                if self.currentLevelController.getLives() == 2 {
                    self.thirdLayerView.removeFromSuperview()
                } else if self.currentLevelController.getLives() == 1 {
                    self.thirdLayerView.removeFromSuperview()
                    self.secondLayerView.removeFromSuperview()
                }
                self.animator.addBehavior(self.swim)
            })
            
            UIHelper.resizeEgg(false, centerLayer: centerLayerView, secondLayer: secondLayerView, thirdLayer: thirdLayerView)
        }
    }
}
