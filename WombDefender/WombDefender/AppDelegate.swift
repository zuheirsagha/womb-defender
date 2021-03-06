//
//  AppDelegate.swift
//  WombDefender
//
//  Created by Ehimare Okoyomon on 2016-10-04.
//  Copyright © 2016 Zoko. All rights reserved.
//

import UIKit
import CoreData
import SpriteKit

public protocol AppDelegateListener : NSObjectProtocol {
    
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SettingsManagerDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        application.isStatusBarHidden = true
        SettingsManager.sharedInstance.initialize()
        SettingsManager.sharedInstance.delegate = self
        AudioManager.sharedInstance.initialize()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "WombDefender")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func onSettingsDidChange() {
        // Does nothing
    }
    
    open var firstTimeOrTutorialPlayed : Bool {
        get {
            return SettingsManager.sharedInstance.firstTimeOrTutorialPlayed
        }
        set {
            SettingsManager.sharedInstance.firstTimeOrTutorialPlayed = newValue
        }
    }
    
    open var username : String {
        get {
            return SettingsManager.sharedInstance.username
        }
        set {
            SettingsManager.sharedInstance.username = newValue
        }
    }
    
    open var appIsMute : Bool {
        get {
            return SettingsManager.sharedInstance.appIsMute
        }
        set {
            SettingsManager.sharedInstance.appIsMute = newValue
        }
    }
    
    open var country : String {
        get {
            return SettingsManager.sharedInstance.country
        }
        set {
            SettingsManager.sharedInstance.country = newValue
        }
    }
    
    open var appFXIsMute : Bool {
        get {
            return SettingsManager.sharedInstance.appFXIsMute
        }
        set {
            SettingsManager.sharedInstance.appFXIsMute = newValue
        }
    }
    
    open var highestScore : Int {
        get {
            return SettingsManager.sharedInstance.highestScore
        }
        set {
            SettingsManager.sharedInstance.highestScore = newValue
        }
    }
    
    open var coins : Int {
        get {
            return SettingsManager.sharedInstance.coins
        }
        set {
            SettingsManager.sharedInstance.coins = newValue
        }
    }
    
    open var difficulty : Difficulty {
        get {
            return SettingsManager.sharedInstance.difficulty
        }
        set {
            SettingsManager.sharedInstance.difficulty = newValue
        }
    }
    
    open var numberOfFirstPowerUps : Int {
        get {
            return SettingsManager.sharedInstance.numberOfFirstPowerUps
        }
        set {
            SettingsManager.sharedInstance.numberOfFirstPowerUps = newValue
        }
    }
    
    open var usernameSelected : Bool {
        get {
            return SettingsManager.sharedInstance.usernameSelected
        }
        set {
            SettingsManager.sharedInstance.usernameSelected = newValue
        }
    }
    
    open var viewedInstructions : Bool {
        get {
            return SettingsManager.sharedInstance.viewedInstructions
        }
        set {
            SettingsManager.sharedInstance.viewedInstructions = newValue
        }
    }
    
    open var numberOfSecondPowerUps : Int {
        get {
            return SettingsManager.sharedInstance.numberOfSecondPowerUps
        }
        set {
            SettingsManager.sharedInstance.numberOfSecondPowerUps = newValue
        }
    }
    
    open var numberOfThirdPowerUps : Int {
        get {
            return SettingsManager.sharedInstance.numberOfThirdPowerUps
        }
        set {
            SettingsManager.sharedInstance.numberOfThirdPowerUps = newValue
        }
    }
}

