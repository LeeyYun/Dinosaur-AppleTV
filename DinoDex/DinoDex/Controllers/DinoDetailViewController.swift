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
    
    @IBOutlet var sceneView: DinoSceneView!
    
    var nameString: String!
    var descriptionString: String!
    var sceneKitString: String!
    
    var currentDino: Dinosaur!
    var currentDinoNode: SCNNode?
    var soundString: String!
    
    @IBOutlet weak var scrollLabel: UILabel!
    @IBOutlet weak var voiceButton: UIButton!
    @IBOutlet weak var feedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        //get root node (dinosaur object)
        getRootNode()
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
        super.viewDidAppear(animated)
        
        animateSpinningDinosaur(1.0)
        addBobbingAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override weak var preferredFocusedView: UIView? {
        if voiceButton.enabled == true {
            return voiceButton
        } else {
            return sceneView
        }
    }
    
    
    func setupView() {
        soundString = currentDino.previewImageName //make sure mp3 file name is same as image preview name
        nameLabel.text = currentDino.nameString
        descriptionLabel.text = currentDino.descriptionString
        
        
    }
    
    
    func getRootNode() {
        sceneView.scene = SCNScene(named: currentDino.sceneKitString)
        guard let node = sceneView.scene?.rootNode
            else {
                return
        }
        self.currentDinoNode = node //save copy of current dino node
    }
    
    func animateSpinningDinosaur(duration: Double) {
        sceneView.allowsCameraControl = false
        let rotateByAxisAction = SCNAction.rotateByAngle(6.28, aroundAxis: SCNVector3.init(0, 1, 0), duration: duration)
        rotateByAxisAction.timingMode = .EaseInEaseOut
        if let node = self.currentDinoNode {
            node.runAction(rotateByAxisAction, completionHandler: { _ in
                self.sceneView.allowsCameraControl = true
            })
        }
    }
    
    func addBobbingAnimation() {
        if let node = self.currentDinoNode {
            var min = SCNVector3Zero
            var max = SCNVector3Zero
            node.getBoundingBoxMin(&min, max: &max)
            let height = max.y - min.y
            let relativeAmount = CGFloat(height/30)
            let moveUp = SCNAction.moveByX(0, y: relativeAmount, z: 0, duration: 1)
            moveUp.timingMode = SCNActionTimingMode.EaseInEaseOut
            let moveDown = SCNAction.moveByX(0, y: (-1 * relativeAmount), z: 0, duration: 1)
            moveDown.timingMode = SCNActionTimingMode.EaseInEaseOut
            let moveSequence = SCNAction.sequence([moveUp,moveDown])
            let moveLoop = SCNAction.repeatActionForever(moveSequence)
            node.runAction(moveLoop)
        }
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
            
            sceneView.userInteractionEnabled = true
            sceneView.becomeFirstResponder()
            
            voiceButton.enabled = false
            feedButton.enabled = false
            
            self.setNeedsFocusUpdate()
            self.updateFocusIfNeeded()
            
            //set label for directions
            scrollLabel.text = "Scroll on touchpad to rotate. Press Play/Pause to end rotating."
            
            //begin dinosaur pulsating animation so user knows he/she can swipe to rotate
            addBobbingAnimation()
        }
        else { //disable spinning
            
            
            sceneView.resignFirstResponder()
            sceneView.userInteractionEnabled = false
            
            
            voiceButton.enabled = true
            feedButton.enabled = true
            
            self.setNeedsFocusUpdate()
            self.updateFocusIfNeeded()
            
            voiceButton.becomeFirstResponder()
            //voiceButton.selected = true
            
            //set label for directions
            scrollLabel.text = "Press Play/Pause to enable rotating."
            
            //reset scene to remove pulsating action, user no longer can swipe to rotate
            getRootNode()
        }
        
    }
    
    
    
    @IBAction func tappedVoiceButton(sender: AnyObject) {
        playSound()
    }
    
    
    
    @IBAction func tappedFeedButton(sender: AnyObject) {
        feedButton.enabled = false
        foodLabel.hidden = false
        let oldFrame = foodLabel.frame
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .CurveEaseOut, animations: { _ in
            
            self.foodLabel.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y + 500, width: oldFrame.width, height: oldFrame.height)
            
            }, completion: { _ in
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveLinear, animations: { _ in
                    self.foodLabel.alpha = 0.0
                    
                    
                    }, completion: { _ in
                        self.foodLabel.hidden = true
                        self.foodLabel.alpha = 1.0
                        self.foodLabel.frame = oldFrame
                        self.feedButton.enabled = true
                        //self.sceneView.scene = SCNScene(named: self.currentDino.sceneKitString)  //replay actions
                        //rotate dino after feeding
                        self.animateSpinningDinosaur(0.5)
                })
                
                
        })
    }
    
    
    
    
    
}

