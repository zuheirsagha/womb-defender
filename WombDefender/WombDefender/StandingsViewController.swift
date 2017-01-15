//
//  ShopViewController.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-11-03.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

struct Score {
    var name: String
    var country: String
    var value: Int
}

class StandingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func onBackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var _titleLabel: UILabel!
    @IBOutlet weak var _regionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var _tableView: UITableView!
    @IBOutlet weak var _spinner: UIActivityIndicatorView!
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Member Variables
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    var _scores = [Score]()
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Lifecycle Methods
    //
    /////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = GradientView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.insertSubview(gradient, at: 0)
        
        // TODO: Check if they allow location settings and set a variable allowing or disallowing them to get settings in their country
        
        // TODO: need to get actually country from userdefaults / location settings
        if _regionSegmentedControl.selectedSegmentIndex == 0 {
            
        }
        else if _regionSegmentedControl.selectedSegmentIndex == 1 {
            
        }
        else {
            
        }
        _spinner.startAnimating()
        getScores(type: .Country, country: "canada") { (scores, error) in
            if (error != nil) {
                // present there was an error, based on what error there was
                print("There was an error - either network or responseStatus. Show the user")
            }
            else if (scores != nil) {
                for score in scores! {
                    let newScore = Score(name: score["user"] as! String, country: score["country"] as! String, value: score["score"] as! Int)
                    self._scores.append(newScore)
                }
                DispatchQueue.main.async {
                    self._tableView.reloadData()
                }
                
            } else {
                print("it tripped out on one of those weird cases where url didnt work or wanted country but didnt allow location. Respond accordingly")
            }
            DispatchQueue.main.async {
                self._spinner.stopAnimating()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LeaderboardCell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell") as! LeaderboardCell
        let score = _scores[indexPath.row]
        
        cell.selectionStyle = .none
        cell._leaderboardPositionLabel.text = "\(indexPath.row + 1)."
        cell._leaderboardNameLabel.text = score.name
        cell._leaderboardScoreLabel.text = "\(score.value)"
        cell._leaderboardCountryLabel.text = score.country
        return cell
    }
}
