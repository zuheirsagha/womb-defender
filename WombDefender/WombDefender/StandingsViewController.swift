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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if _regionSegmentedControl.selectedSegmentIndex == 0 {
            loadData(type: .Country)
        }
        else if _regionSegmentedControl.selectedSegmentIndex == 1 {
            loadData(type: .World)
        }
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
    
    @IBAction func typeSelected(_ sender: Any) {
        if _regionSegmentedControl.selectedSegmentIndex == 0 {
            loadData(type: .Country)
        }
        else if _regionSegmentedControl.selectedSegmentIndex == 1 {
            loadData(type: .World)
        }
    }
    
    
    private func loadData(type: ScoreType) {
        _spinner.startAnimating()
        if (currentReachabilityStatus == .notReachable) {
            _spinner.stopAnimating()
            let alertController = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        getScores(type: type, country: self.appDelegate.country) { (scores, error) in
            if (scores != nil) {
                self._scores.removeAll()
                for score in scores! {
                    let newScore = Score(name: score["user"] as! String, country: score["country"] as! String, value: score["score"] as! Int)
                    self._scores.append(newScore)
                }
                DispatchQueue.main.async {
                    self._tableView.reloadData()
                }
                
            } else {
                // present there was an error, based on what error there was
                print("There was an error - either network or responseStatus. Show the user")
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Error", message: "Cannot load scores at this time, sorry.", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                        print("You've pressed OK button");
                    }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
            DispatchQueue.main.async {
                self._spinner.stopAnimating()
            }
        }
    }
}
