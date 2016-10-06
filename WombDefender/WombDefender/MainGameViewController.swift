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
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
