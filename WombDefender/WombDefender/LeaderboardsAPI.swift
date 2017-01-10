//
//  LeaderboardsAPI.swift
//  WombDefender
//
//  Created by Ehimare Okoyomon on 2017-01-09.
//  Copyright © 2017 Zoko. All rights reserved.
//

import Foundation

let BASE_URL = "wombdefender.herokuapp.com"
let SCORES_URL = BASE_URL + "/scores"

enum Score {
    case World
    case Country
}

func postScore(score: Int, forUser user: String, country: String?) {
    guard let requestURL = URL(string: SCORES_URL) else {
        print("Cant create URL")
        return
    }
    var request = URLRequest(url: requestURL)
    
    request.httpMethod = "POST"
    
    var postString = "userName=\(user)&score=\(score)"
    if let country = country {
        postString += "&country=\(country)"
    }
    
    request.httpBody = postString.data(using: .utf8)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            // Some sort of network error -
            print("error=\(error)")
            return // do something
        }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 201 {
            // check for if something went wrong then display it to user
            print("statusCode should be 201, but is \(httpStatus.statusCode)")
            print("response = \(response)")
            return //do something - tell user there was internet error
        }
        
        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(responseString)")
        // Let them know it successfully uploaded
    }
    task.resume()
    
}

func getScores(type: Score, country: String?) {
    
    var url = SCORES_URL
    if type == .World {
        url += "?type=world"
    } else if type == .Country, let country = country {
        url += "?type=country&country=\(country)"
    } else {
        // Do something, they wanted country but dont have country settings
        print("lol wut, there are no other options")
        return
    }
    
    guard let requestURL = URL(string: url) else {
        print("Cant create URL")
        return
    }
    var request = URLRequest(url: requestURL)
    
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            // Some sort of network error -
            print("error=\(error)")
            return // do something - tell user there was internet error
        }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            // check for if something went wrong then display it to user
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(response)")
            return //do something
        }
        
        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(responseString)")
        // call a function to display the data, based on the type of Score passed in (country or world)
    }
    task.resume()
    
}
