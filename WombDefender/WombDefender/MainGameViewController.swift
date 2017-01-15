//
//  MainGameViewController.swift
//  WombDefender
//
//  Created by Ehimare Okoyomon on 2016-10-05.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit
import SpriteKit

class MainGameViewController: UIViewController, LevelControllerDelegate, UICollisionBehaviorDelegate, SwipeViewDelegate {
    
    @IBOutlet weak var _condomWrapperImageView: UIImageView!
    @IBOutlet weak var _powerUpView: UIView!
    @IBOutlet weak var _powerUpBackgroundImageView: UIImageView!
    
    @IBOutlet weak var _firstPowerUpLabel: UILabel!
    @IBOutlet weak var _firstPowerUpButton: UIButton!
    
    @IBOutlet weak var _secondPowerUpLabel: UILabel!
    @IBOutlet weak var _secondPowerUpButton: UIButton!

    @IBOutlet weak var _thirdPowerUpLabel: UILabel!
    @IBOutlet weak var _thirdPowerUpButton: UIButton!
    
    @IBOutlet weak var _settingsScreenMuteButton: UIButton!
    @IBOutlet weak var _settingsMenuView: UIView!
    @IBOutlet var _mainGameView: UIView!
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
    @IBOutlet weak var _endGameCoinsLabel: UILabel!

    @IBOutlet var _swipeView: SwipeView!
    
    @IBOutlet weak var _levelBanner: UIView!
    @IBOutlet weak var _levelBannerLabel: UILabel!
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Member Variables
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
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
    
    // Circles for egg and corresponding views
    var centerLayerView: UIView!
    var secondLayerView: UIView!
    var thirdLayerView: UIView!
    
    // Date timestamp to say this is current game. B/c will be unique.
    var currentGame = Date()
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Lifecycle Methods
    //
    /////////////////////////////////////////////////////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = GradientView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.insertSubview(gradient, at: 0)
        
        _condomWrapperImageView.isHidden = true
        
        _levelBanner.isHidden = false
        
        let left = CGPoint(x: -2*_levelBanner.frame.width, y: view.center.y)
        _levelBanner.center = left
        
        _settingsMenuView.isHidden = true
        
        _swipeView.setDelegate(self)
        
        _startGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Actions/Selectors
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func onFirstPowerUpPressed(_ sender: UIButton) {
        if currentLevelController.getLives() != 0 {
            if appDelegate.numberOfFirstPowerUps > 0 {
                appDelegate.numberOfFirstPowerUps -= 1
                _reloadViews()
            }
            else {
                // do nothing
            }
        }
    }

    @IBAction func onSecondPowerUpPressed(_ sender: UIButton) {
        if currentLevelController.getLives() != 0 {
            if appDelegate.numberOfSecondPowerUps > 0 {
                if _condomWrapperImageView.isHidden == true {
                    appDelegate.numberOfSecondPowerUps -= 1
                    _condomWrapperImageView.superview?.bringSubview(toFront: _condomWrapperImageView)
                    _condomWrapperImageView.isHidden = false
                    currentLevelController.setLives(lives: currentLevelController.getLives()+1)
                    _reloadViews()
                }
            }
            else {
                // do nothing
            }
        }
    }
    
    @IBAction func onThirdPowerUpPressed(_ sender: UIButton) {
        if currentLevelController.getLives() != 0 {
            if appDelegate.numberOfThirdPowerUps > 0 {
                appDelegate.numberOfThirdPowerUps -= 1
                for sperm in sperms {
                    if sperm.frame.origin.x > 0 && sperm.frame.origin.x+sperm.frame.width < self.view.frame.width && sperm.frame.origin.y > 0 && sperm.frame.origin.y+sperm.frame.height < self.view.frame.height {
                        
                    }
                    if (!sperm.isDead()) {
                        sperm.killSperm()
                    }
                }
            }
            else {
                // do nothing
            }
        }
    }
    
    @IBAction func onCancelSettingsPressed(_ sender: UIButton) {
        self.animator.addBehavior(self.swim)
        UIView.animate(withDuration: 0.5, animations: {
            self._settingsMenuView.alpha = 0
        }, completion: { (Bool) in
            self._settingsMenuView.isHidden = true
            self._settingsMenuView.alpha = 0
        })
    }
    
    @IBAction func onSettingsRestartGamePressed(_ sender: UIButton) {
        _resetGame()
        _startGame()
    }
    
    @IBAction func onSettingsHomePressed(_ sender: UIButton) {
        _resetGame()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSettingsMutePressed(_ sender: UIButton) {
        appDelegate.appFXIsMute = !appDelegate.appFXIsMute
        _reloadViews()
    }
    
    @IBAction func onSettingsButtonPressed(_ sender: UIButton) {
        animator.removeAllBehaviors()
        _settingsMenuView.alpha = 0
        _settingsMenuView.superview?.bringSubview(toFront: _settingsMenuView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self._settingsMenuView.alpha = 1
        })
        _settingsMenuView.isHidden = false
    }
    
    @IBAction func onEndGameHomeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onEndGameRestartButtonPressed(_ sender: UIButton) {
        _startGame()
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // LevelControllerDelegate Methods
    //
    /////////////////////////////////////////////////////////////////////////////////////

    func gameIsOver() {
        _resetGame()
        
        _firstHeartImageView.image = #imageLiteral(resourceName: "pacifier_full")
        _secondHeartImageView.image = #imageLiteral(resourceName: "pacifier_full")
        _thirdHearImageView.image = #imageLiteral(resourceName: "pacifier_full")
        
        let endGameScore = currentLevelController.getScore()
        _scoreLabel.text = "\(endGameScore)"
        
        _endGameCoinsLabel.text = "\(endGameScore/1000)"
        appDelegate.coins = appDelegate.coins + (endGameScore/1000)
        
        if endGameScore > appDelegate.highestScore {
            appDelegate.highestScore = endGameScore
            // TODO: Make it present a view asking if they want to submit this score, allowing them to put a username maybe.
            postScore(score: endGameScore, forUser: "Ehimare", country: "canada")
        }
        
        centerLayerView.isHidden = true
        
        _endGameView.alpha = 0.0
        _endGameView.isHidden = false
        _endGameScoreLabel.text = "\(currentLevelController.getScore())"
        _endGameBestScoreLabel.text = NSLocalizedString("best_score", param1: appDelegate.highestScore)
        UIView.transition(with: _endGameView, duration: 0.5, options: UIViewAnimationOptions.allowAnimatedContent, animations: {self._endGameView.alpha=1.0}, completion: nil)
    }
    
    func nextLevel() {
        print("next level")
        _showLevelBanner("Level \(currentLevelController.level!)")
    }
    
    func removeSpermViewAtIndex(index: Int) {
        if (index < sperms.count) {
            sperms[index].removeFromSuperview()
        }
    }
    
    func demoteSpermViewAtIndex(index: Int) {
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
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // CollisionBehaviourDelegate Methods
    //
    /////////////////////////////////////////////////////////////////////////////////////

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        if (identifier != nil) {
            let idAsString = identifier as! String
            
            if (idAsString == KEY_OUTER_BARRIER || idAsString == KEY_CENTER_BARRIER || idAsString == KEY_INNER_BARRIER) {
                if !appDelegate.appFXIsMute {
                    AudioManager.sharedInstance.playSound(.spermDied)
                }
                if _condomWrapperImageView.isHidden == false {
                    _condomWrapperImageView.isHidden = true
                    _reloadViews()
                }
                if let item = item as? SpermView {
                    // keep in this order so that banner does not show
                    // must update lives first to check if lives is zero
                    currentLevelController.spermHitEgg()
                    item.spermJustHitBoundary()
                }
            }
            else if (idAsString == KEY_SWIPE_IDENTIFIER) {
                if !appDelegate.appFXIsMute {
                    AudioManager.sharedInstance.playSound(.spermDied)
                }
                if let item = item as? SpermView {
                    item.spermJustHitBoundary()
                }
                _swipeView.isHit = true
                _swipeView.swipePath.removeAllPoints()
                _swipeView.setNeedsDisplay()
                SpermBehaviour.collider.removeBoundary(withIdentifier: KEY_SWIPE_IDENTIFIER as NSCopying)
                _reloadViews()
            }
        }
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Private Methods
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    fileprivate func _reloadViews() {
        
        _scoreLabel.text = "\(currentLevelController.getScore())"
        
        _reloadPowerUps()

        let outerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/4.25), startAngle: 0, endAngle: 2*3.14159, clockwise: true)
        let centerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/5), startAngle: 0, endAngle: 2*3.14159, clockwise: true)
        let innerRing = UIBezierPath(arcCenter: view.center, radius: CGFloat(view.frame.width/6), startAngle: 0, endAngle: 2*3.14159, clockwise: true)
        
        let lives = currentLevelController.getLives()
        
        SpermBehaviour.collider.removeBoundary(withIdentifier: KEY_INNER_BARRIER as NSCopying)
        SpermBehaviour.collider.removeBoundary(withIdentifier: KEY_OUTER_BARRIER as NSCopying)
        SpermBehaviour.collider.removeBoundary(withIdentifier: KEY_CENTER_BARRIER as NSCopying)
        
        if lives >= 3 {
            SpermBehaviour.collider.addBoundary(withIdentifier: KEY_OUTER_BARRIER as NSCopying, for: outerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "pacifier_empty")
            _secondHeartImageView.image = #imageLiteral(resourceName: "pacifier_empty")
            _thirdHearImageView.image = #imageLiteral(resourceName: "pacifier_empty")
        } else if lives == 2 {
            SpermBehaviour.collider.addBoundary(withIdentifier: KEY_CENTER_BARRIER as NSCopying, for: centerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "pacifier_full")
            _secondHeartImageView.image = #imageLiteral(resourceName: "pacifier_empty")
            _thirdHearImageView.image = #imageLiteral(resourceName: "pacifier_empty")
            thirdLayerView.isHidden = true
        } else if lives == 1 {
            SpermBehaviour.collider.addBoundary(withIdentifier: KEY_INNER_BARRIER as NSCopying, for: innerRing)
            _firstHeartImageView.image = #imageLiteral(resourceName: "pacifier_full")
            _secondHeartImageView.image =  #imageLiteral(resourceName: "pacifier_full")
            _thirdHearImageView.image = #imageLiteral(resourceName: "pacifier_empty")
            secondLayerView.isHidden = true
        }
        
        if appDelegate.appFXIsMute {
            _settingsScreenMuteButton.setImage(#imageLiteral(resourceName: "appIsMute"), for: .normal)
        }
        else {
            _settingsScreenMuteButton.setImage(#imageLiteral(resourceName: "appIsNotMute"), for: .normal)
        }
    }
    
    fileprivate func _reloadPowerUps() {
        _firstPowerUpLabel.text = "\(appDelegate.numberOfFirstPowerUps)"
        _secondPowerUpLabel.text = "\(appDelegate.numberOfSecondPowerUps)"
        _thirdPowerUpLabel.text = "\(appDelegate.numberOfThirdPowerUps)"
        
        if appDelegate.numberOfFirstPowerUps == 0 {
            _firstPowerUpButton.tintColor = UIColor.gray
        }
        else {
            _firstPowerUpButton.tintColor = UIColor.white
        }
        
        if appDelegate.numberOfSecondPowerUps == 0 {
            _secondPowerUpButton.tintColor = UIColor.gray
        }
        else {
            _secondPowerUpButton.tintColor = UIColor.white
        }
        
        if appDelegate.numberOfThirdPowerUps == 0 {
            _thirdPowerUpButton.tintColor = UIColor.gray
        }
        else {
            _thirdPowerUpButton.tintColor = UIColor.white
        }
    }
    
    fileprivate func _drawWomb() {
        let views = UIHelper.drawWomb(view.frame.width, height: view.frame.height)
        centerLayerView = views[0]
        secondLayerView = views[1]
        thirdLayerView = views[2]
        _mainGameView.addSubview(centerLayerView)
        _mainGameView.addSubview(secondLayerView)
        _mainGameView.addSubview(thirdLayerView)
    }
    
    fileprivate func _startGame() {
        currentGame = Date()
        _endGameView.isHidden = true
        _settingsMenuView.isHidden = true
        animator = UIDynamicAnimator(referenceView: self.view)        
        currentLevelController = getNewLevelControllerWithCurrentDifficulty(gameController: self, difficulty: appDelegate.difficulty)
        currentLevelController.restart()
        
        sperms = [SpermView]()
        swim = SpermBehaviour(centreX: self.view.frame.midX, centreY: self.view.frame.midY)
        SpermBehaviour.collider.collisionDelegate = self
        
        total = currentLevelController.numberOfSperm
        interval = currentLevelController.interval()
        
        swim.setFieldStrength(strength: currentLevelController.fieldStrength())
        
        _drawWomb()
        _reloadViews()
        animator.addBehavior(swim)
        //print("\(!appDelegate.firstTimeOrTutorialPlayed)")
        //if !appDelegate.firstTimeOrTutorialPlayed {
        //    let sperm = SpermView.createSpermViewAt(x: -20, y: -20, size: .Regular, controller: currentLevelController, index: 0)
        //    self.view.insertSubview(sperm, at: 1)
        //    sperms.insert(sperm, at: 0)
        //   swim.addItem(item: sperm)
        //
        //    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
        //        self.animator.removeAllBehaviors()
        //    }
            
        //    appDelegate.firstTimeOrTutorialPlayed = !appDelegate.firstTimeOrTutorialPlayed
        //}
        //else {
            createSperm()
        //}
    }
    
    fileprivate func createSperm() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(interval)) {
            print("\(self.total)")
            if self._settingsMenuView.isHidden == true && self.total > 0 {
                self._createSperm()
                self.total = self.total - 1
            }
            if self.total > 0 {
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
        
        let spermType : SpermType!
        let rand = arc4random_uniform(100)
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
    
    fileprivate func _showLevelBanner(_ text : String) {
        print("showing level banner")
        _levelBannerLabel.text = "\(text)"
        _levelBanner.superview?.bringSubview(toFront: _levelBanner)
        let left = CGPoint(x: -2*_levelBanner.frame.width, y: view.center.y)
        let right = CGPoint(x: 2*_levelBanner.frame.width, y: view.center.y)
        self._levelBanner.center = left
        self._moveView(self._levelBanner, toPoint: self.view.center, thenPoint: right, isShowing: true)
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500), execute: {
//            self._moveView(self._levelBanner, toPoint: right, isShowing: false)
//        })
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500), execute: {
//            print("creating sperm")
//            self.total = self.currentLevelController.numberOfSperm
//            self.createSperm()
//        })
    }
    
    fileprivate func _resetGame() {
        SpermBehaviour.collider.removeAllBoundaries()
        _swipeView.swipePath.removeAllPoints()
        _swipeView.setNeedsDisplay()
        for sperm in sperms {
            sperm.removeFromSuperview()
            swim.removeItem(item: sperm)
        }
        
        centerLayerView.removeFromSuperview()
        secondLayerView.removeFromSuperview()
        thirdLayerView.removeFromSuperview()
        
        sperms.removeAll()
        total = 0
        interval = 0
        
        animator.removeAllBehaviors()
    }
    
    fileprivate func getNewLevelControllerWithCurrentDifficulty(gameController: MainGameViewController, difficulty: Difficulty) -> LevelController {
        switch (difficulty) {
        case .Easy:
            return EasyLevelController(delegate: gameController)
        case .Medium:
            return MediumLevelController(delegate: gameController)
        case .Hard:
            return HardLevelController(delegate: gameController)
        }
    }
    
    fileprivate func _moveView(_ view:UIView, toPoint stop:CGPoint, thenPoint destination:CGPoint, isShowing : Bool) {
    //Always animate on main thread
        view.isHidden = false
        let thisGame = currentGame

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            // dont do it at all if they exited
            if (!(thisGame == self.currentGame)) {
                return;
            }
            UIView.animate(
                withDuration: 1.0,
                delay: 0.0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.3,
                options: UIViewAnimationOptions.allowAnimatedContent,
                animations: { () -> Void in
                    //do actual move
                    view.center = stop },
                completion: {bool in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750), execute: {
                        UIView.animate(
                            withDuration: 1.0,
                            delay: 0.0,
                            usingSpringWithDamping: 1.0,
                            initialSpringVelocity: 0.3,
                            options: UIViewAnimationOptions.allowAnimatedContent,
                            animations: { () -> Void in
                                //do actual move
                                view.center = destination },
                            completion: { bool in
                                // Dont set the total or create new ones if they exited.
                                if (!(thisGame == self.currentGame)) {
                                    return;
                                }
                                print("creating sperm")
                                self.total = self.currentLevelController.numberOfSperm
                                self.createSperm()
                        })
                    })
            })
        })
    }
    
    func firstSwipe() {
        animator.addBehavior(swim)
    }
}
