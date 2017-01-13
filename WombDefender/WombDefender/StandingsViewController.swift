//
//  ShopViewController.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-11-03.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

class StandingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func onBackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var _titleLabel: UILabel!
    @IBOutlet weak var _regionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var _tableView: UITableView!
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LeaderboardCell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell") as! LeaderboardCell
        cell.selectionStyle = .none
        cell._leaderboardPositionLabel.text = "1."
        cell._leaderboardNameLabel.text = "Zuheir"
        cell._leaderboardCountryLabel.text = "Canada"
        return cell
    }
}
