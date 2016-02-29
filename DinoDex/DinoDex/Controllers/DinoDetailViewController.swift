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
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var sceneView: SCNView!
    
    var nameString: String!
    var descriptionString: String!
    var sceneKitString: String!
    
    var currentDino: Dinosaur!
    var soundString: String!
    
    @IBOutlet weak var scrollLabel: UILabel!
    @IBOutlet weak var voiceButton: UIButton!
    @IBOutlet weak var feedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        if(presses.first?.type == UIPressType.PlayPause) { //user pressed play/pause button, toggle spin action
            toggleSpinDino()
        } else {
            // perform default action (in your case, exit)
            super.pressesBegan(presses, withEvent: event)
        }
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
    func toggleSpinDino() {
        if voiceButton.enabled { //enable spinning
            feedButton.resignFirstResponder()
            voiceButton.resignFirstResponder()
            
            voiceButton.enabled = false
            feedButton.enabled = false
            
            //set label for directions
            scrollLabel.text = "Scroll on touchpad to rotate. Press Play/Pause when done."
        }
        else { //disable spinning
            voiceButton.becomeFirstResponder()
            voiceButton.enabled = true
            feedButton.enabled = true
            
            //set label for directions
            scrollLabel.text = "Press Play/Pause to enable rotating."
        }
        
    }
    
    
    
    @IBAction func tappedVoiceButton(sender: AnyObject) {
        playSound()
    }
    
    
    
    @IBAction func tappedFeedButton(sender: AnyObject) {
        feedButton.enabled = false
        foodLabel.hidden = false
        let oldFrame = foodLabel.frame
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveEaseOut, animations: { _ in
            
            self.foodLabel.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y + 500, width: oldFrame.width, height: oldFrame.height)
            
            }, completion: { _ in
                self.foodLabel.hidden = true
                self.foodLabel.frame = oldFrame
                self.feedButton.enabled = true
                
        })
    }
    
    
    func setupView() {
        nameLabel.text = currentDino.nameString
        descriptionLabel.text = currentDino.descriptionString
        sceneView.scene = SCNScene(named: currentDino.sceneKitString)
        soundString = currentDino.previewImageName //make sure mp3 file name is same as image preview name
        
    }
    
    
}

