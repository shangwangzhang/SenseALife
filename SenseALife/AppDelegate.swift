//
//  AppDelegate.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 12/20/15.
//  Copyright © 2015 ShangWang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let pumpingGas = UIMutableUserNotificationAction()
        pumpingGas.identifier = "DELAY_ALERT"
        pumpingGas.title = "Delay"
        pumpingGas.activationMode = UIUserNotificationActivationMode.background
        pumpingGas.isAuthenticationRequired = true
        pumpingGas.isDestructive = true
        
        let babyRemoved = UIMutableUserNotificationAction()
        babyRemoved.identifier = "BABY_REMOVED"
        babyRemoved.title = "OK"
        babyRemoved.activationMode = UIUserNotificationActivationMode.background
        babyRemoved.isAuthenticationRequired = true
        babyRemoved.isDestructive = false
        
        let senseALifeCategory = UIMutableUserNotificationCategory()
        senseALifeCategory.identifier = "COUNTER_CATEGORY"
        
        // A. Set actions for the default context
        senseALifeCategory.setActions([pumpingGas, babyRemoved],
        for: UIUserNotificationActionContext.default)
        
        // B. Set actions for the minimal context
        senseALifeCategory.setActions([pumpingGas, babyRemoved],
        for: UIUserNotificationActionContext.minimal)
        
        
        
        let types:UIUserNotificationType = ([.alert, .sound, .badge])
        let notificationSettings = UIUserNotificationSettings(types: types, categories: NSSet(object: senseALifeCategory) as? Set<UIUserNotificationCategory>)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        
        // Override point for customization after application launch.
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
        
        
        
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?,
                     for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        
        // Handle notification action *****************************************
        if notification.category == "COUNTER_CATEGORY" {
            
            let action = identifier!
            
            switch action{
                
            case "DELAY_ALERT":
                DashboardController().setNotificationSenseALife(10)
                
                break
            case "BABY_REMOVED":
                DashboardController().clearNotificationSenseALife()
                break
            default:
                break
            }
        }
        
        completionHandler()
    }
}

