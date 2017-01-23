//
//  StartScreenViewController.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-10-05.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit
import CoreLocation

class StartScreenViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var _headerView: UIView!
    @IBOutlet weak var _titleImageView: UIImageView!
    @IBOutlet weak var _tapToStartLabel: UILabel!
    @IBOutlet weak var _settingsButton: UIButton!
    @IBOutlet weak var _shoppingCartButton: UIButton!
    @IBOutlet weak var _standingsButton: UIButton!
    @IBOutlet weak var _tapToStartButton: UIButton!
    @IBOutlet weak var _backgroundView: UIView!
    @IBOutlet weak var _difficultySegmentedControl: UISegmentedControl!
    @IBOutlet weak var settingsView: UIView!
    
    @IBOutlet weak var musicCheckBoxButton: UIButton!
    @IBOutlet weak var soundFXCheckBoxButton: UIButton!
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Member Variables
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    fileprivate var settingsPressed = false
    
    //Circles for egg and corresponding views
    fileprivate var centerLayerView: UIView!
    fileprivate var secondLayerView: UIView!
    fileprivate var thirdLayerView: UIView!
    
    let _locationManager = CLLocationManager()
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Lifecycle Methods
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = GradientView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.insertSubview(gradient, at: 0)
       
        let views = UIHelper.drawWomb(view.frame.width, height: view.frame.height)
        
        if appDelegate.difficulty == .Easy {
            _difficultySegmentedControl.setEnabled(true, forSegmentAt: 0)
        }
        else if appDelegate.difficulty == .Medium {
            _difficultySegmentedControl.setEnabled(true, forSegmentAt: 1)
        }
        else {
            _difficultySegmentedControl.setEnabled(true, forSegmentAt: 2)
        }
        
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.requestWhenInUseAuthorization()
        _locationManager.startUpdatingLocation()
        
        settingsView.isHidden = true
        
        centerLayerView = views[0]
        secondLayerView = views[1]
        thirdLayerView = views[2]
        
        view.insertSubview(centerLayerView, at: 1)
        view.insertSubview(secondLayerView, at: 1)
        view.insertSubview(thirdLayerView, at: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (!appDelegate.usernameSelected) {
            pickUsername()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _reloadViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Actions/Selectors
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func onCancelSettingsPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.settingsView.alpha = 0
        }, completion: { (Bool) in
            self.settingsView.isHidden = true
            self.settingsView.alpha = 0
        })
    }
    
    @IBAction func onSoundFXSettingPressed(_ sender: UIButton) {
        appDelegate.appFXIsMute = !appDelegate.appFXIsMute
        _reloadViews()
    }
    
    @IBAction func onMusicSettingPressed(_ sender: UIButton) {
        appDelegate.appIsMute = !appDelegate.appIsMute
        _reloadViews()
    }
    
    @IBAction func onTapToStartButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToMainGameViewController", sender: self)
    }
    
    @IBAction func onSettingsButtonClicked(_ sender: UIButton) {
        
        settingsView.alpha = 0
        settingsView.superview?.bringSubview(toFront: settingsView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.settingsView.alpha = 1
        })
        settingsView.isHidden = false
    }
    
    @IBAction func onShoppingCartButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func onStandingsButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func onDifficultyValueChanged(_ sender: Any, forEvent event: UIEvent) {
        if _difficultySegmentedControl.selectedSegmentIndex == 0 {
            appDelegate.difficulty = .Easy
        }
        else if _difficultySegmentedControl.selectedSegmentIndex == 1 {
            appDelegate.difficulty = .Medium
        }
        else {
            appDelegate.difficulty = .Hard
        }
    }
    
    open func _reloadViews() {
        if appDelegate.appFXIsMute {
            soundFXCheckBoxButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        else {
            soundFXCheckBoxButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
        
        if appDelegate.appIsMute {
            musicCheckBoxButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        else {
            musicCheckBoxButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) in
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks?.count != 0 {
                let pm = (placemarks?[0])! as CLPlacemark
                self.appDelegate.country = pm.country!
                manager.stopUpdatingLocation()
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error updating location: \(error.localizedDescription)")
    }
    
    private func pickUsername() {
        let alertController = UIAlertController(title: "Select Username", message: "You must choose a name between 4 and 12 characters for the leaderboards.", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Done!", style: .default) { (action:UIAlertAction) in
            if alertController.textFields![0].text == nil || alertController.textFields![0].text == "" {
                return self.pickUsername()
            }
            let text = alertController.textFields![0].text!
            if text.characters.count < 4 || text.characters.count > 12 {
                return self.pickUsername()
            }
            
            self.appDelegate.username = alertController.textFields![0].text!
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter username"
        }
        
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion: nil)
        
        appDelegate.usernameSelected = true
    }
}
