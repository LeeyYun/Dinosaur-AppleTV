//
//  FirstViewController.swift
//  DinoDex
//
//  Created by Nathan Hekman on 1/18/16.
//  Copyright © 2016 NTH. All rights reserved.
//

import UIKit
import SceneKit
import AudioToolbox

class DinoDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var sceneView: SCNView!
    
    var nameString: String!
    var descriptionString: String!
    var sceneKitString: String!
    
    var currentDino: Dinosaur!
    var soundString: String!
    
    
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var voiceButton: UIButton!
    @IBOutlet weak var feedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSound() {
        if let soundURL = NSBundle.mainBundle().URLForResource(soundString, withExtension: "mp3") {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        }
        
    }
    @IBAction func tappedSpinButton(sender: AnyObject) {
        spinButton.resignFirstResponder()
        spinButton.enabled = false
        voiceButton.enabled = false
        feedButton.enabled = false
    }

    
    
    @IBAction func tappedVoiceButton(sender: AnyObject) {
        playSound()
    }
    
    
    
    @IBAction func tappedFeedButton(sender: AnyObject) {
        
    }

    
    func setupView() {
        nameLabel.text = currentDino.nameString
        descriptionLabel.text = currentDino.descriptionString
        sceneView.scene = SCNScene(named: currentDino.sceneKitString)
        soundString = currentDino.previewImageName //make sure mp3 file name is same as image preview name
        
    }
    
    
}

