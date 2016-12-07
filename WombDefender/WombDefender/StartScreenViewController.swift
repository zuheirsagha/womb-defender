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
       
        let views = UIHelper.drawWomb(view.frame.width, height: view.frame.height)
        
        centerLayerView = views[0]
        secondLayerView = views[1]
        thirdLayerView = views[2]
        
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
        if !settingsPressed {
            _tapToStartButton.isEnabled = false
            settingsPressed = !settingsPressed
            UIHelper.resizeEgg(true, centerLayer: centerLayerView, secondLayer: secondLayerView, thirdLayer: thirdLayerView)
        } else {
            _tapToStartButton.isEnabled = true
            settingsPressed = !settingsPressed
            UIHelper.resizeEgg(false, centerLayer: centerLayerView, secondLayer: secondLayerView, thirdLayer: thirdLayerView)
        }
    }
    
    @IBAction func onShoppingCartButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToShopViewController", sender: self)
    }
    @IBAction func onStandingsButtonClicked(_ sender: UIButton) {
    }
    
}
