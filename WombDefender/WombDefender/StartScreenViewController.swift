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
    
    //Circles for egg and corresponding views
    fileprivate var centerLayerView: UIView!
    fileprivate var secondLayerView: UIView!
    fileprivate var thirdLayerView: UIView!
    
    /************************************************************************************
     *
     * LIFECYCLE METHODS
     *
     ***********************************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = GradientView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.insertSubview(gradient, at: 0)
       
        centerLayerView = UIView(frame: CGRect(x: view.frame.size.width/2 - CGFloat(view.frame.width/6),
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
        
        view.insertSubview(centerLayerView, at: 1)
        view.insertSubview(secondLayerView, at: 1)
        view.insertSubview(thirdLayerView, at: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.centerLayerView.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
            self.secondLayerView.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
            self.thirdLayerView.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
        })
        
    }
    
    @IBAction func onShoppingCartButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToShopViewController", sender: self)
    }
    @IBAction func onStandingsButtonClicked(_ sender: UIButton) {
    }
    
}
