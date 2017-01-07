//
//  ShopViewController.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-11-03.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var _tableView: UITableView!
    
    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Lifecycle Methods
    //
    /////////////////////////////////////////////////////////////////////////////////////
    @IBAction func onExitButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PowerUpCell = tableView.dequeueReusableCell(withIdentifier: "powerUpCell") as! PowerUpCell
        cell.selectionStyle = .none
        cell._powerUpPriceButton.layer.cornerRadius = 8
        cell._powerUpPriceButton.clipsToBounds = true
        cell._powerUpPriceButton.layer.borderWidth = 1
        cell._powerUpPriceButton.layer.borderColor = UIColor.white.cgColor
        
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell._powerUpImage.image = #imageLiteral(resourceName: "condom")
                cell._powerUpNameLabel.text = "Condom"
                cell._powerUpDescriptionLabel.text = "Extra life!"
                cell._powerUpPriceButton.setTitle("$0.99", for: .normal)
            }
            else if indexPath.row == 1 {
                
            }
            else if indexPath.row == 2 {
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

}
