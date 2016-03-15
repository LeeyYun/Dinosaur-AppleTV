//
//  AppDelegate.swift
//  DinoDex
//
//  Created by Nathan Hekman on 1/18/16.
//  Copyright © 2016 NTH. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var player : AVAudioPlayer! = nil // will be Optional, must supply initializer


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        if let musicBooleanString = Utils.retrieveStringFromUserDefaultsKey("backgroundDinoMusic") {
            if musicBooleanString == "true" {
                startBackgroundMusic()
            }
        }
        else { //settings not yet saved, so play music by default
            startBackgroundMusic()
            Utils.updateUserDefaultsKeyWithString("backgroundDinoMusic", message: "true")
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        player.pause()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        if let musicBooleanString = Utils.retrieveStringFromUserDefaultsKey("backgroundDinoMusic") {
            if musicBooleanString == "true" {
                player.play()
            }
        }
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func startBackgroundMusic() {
        if let path = NSBundle.mainBundle().pathForResource("background", ofType:"mp3") {
            let fileURL = NSURL(fileURLWithPath: path)
            do {
                player = nil
                player = try AVAudioPlayer(contentsOfURL: fileURL)
                player.numberOfLoops = -1
                player.volume = 0.5
                player.prepareToPlay()
                //player.delegate = self
                player.play()
            }
            catch {
                print("Error getting the audio file")
            }
        }
    }


}

