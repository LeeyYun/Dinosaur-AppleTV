//
//  SecondViewController.swift
//  DinoDex
//
//  Created by Nathan Hekman on 1/18/16.
//  Copyright © 2016 NTH. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var musicButton: UIButton!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var musicIsPlaying = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupMusicButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupMusicButton() {
        //get saved value from user defaults, if any
        
        if let musicBooleanString = Utils.retrieveStringFromUserDefaultsKey("backgroundDinoMusic") {
            if musicBooleanString == "true" {
                musicIsPlaying = true
                musicButton.setTitle("Background Music: ON", forState: .Normal)
            }
            else {
                musicIsPlaying = false
                musicButton.setTitle("Background Music: OFF", forState: .Normal)
            }
        }
    }
    
    
    //toggle music on/off
    @IBAction func tappedMusicButton(sender: AnyObject) {
        if musicIsPlaying == true { //turn off music if playing
            Utils.updateUserDefaultsKeyWithString("backgroundDinoMusic", message: "false")
            appDelegate.player.pause()
            musicIsPlaying = false
            musicButton.setTitle("Background Music: OFF", forState: .Normal)
        }
        else { //turn on music if stopped
            Utils.updateUserDefaultsKeyWithString("backgroundDinoMusic", message: "true")
            appDelegate.startBackgroundMusic()
            musicIsPlaying = true
            musicButton.setTitle("Background Music: ON", forState: .Normal)
        }
        
        
    }
    
    @IBAction func tappedRestore(sender: AnyObject) {
        // Restore purchases to this device.
        DinoProducts.store.restoreCompletedTransactions()
    }
    
}

