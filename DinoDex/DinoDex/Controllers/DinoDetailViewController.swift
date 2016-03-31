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
import AVFoundation

class DinoDetailViewController: UIViewController {
    
    @IBOutlet weak var instructionView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UIVerticalAlignLabel!
    @IBOutlet var sceneView: DinoSceneView!
    @IBOutlet weak var goalBarView: UIView!
    @IBOutlet weak var healthLabel: UILabel!
    
    @IBOutlet weak var goalBarTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var goalBarTopConstraint: NSLayoutConstraint!
    var nameString: String!
    var descriptionString: String!
    var sceneKitString: String!
    
    var isPlayingVoice = false
    
    var currentDino: Dinosaur!
    var currentDinoNode: SCNNode?
    var soundString: String!
    var player : AVAudioPlayer! = nil // will be Optional, must supply initializer
    
    var healthHeightLevel: CGFloat = 796
    
    @IBOutlet weak var scrollLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        //get root node (dinosaur object)
        getRootNode()
        
        
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        if(presses.first?.type == UIPressType.PlayPause) { //user pressed play/pause button, toggle spin action
            //toggleSpinDino()
            if (isPlayingVoice == false) {
                playNarration()
            }
            else {
                stopNarration()
            }
        }
        else if (presses.first?.type == UIPressType.Select) {
            tappedFeedButton()
        }
        else {
            // perform default action (in your case, exit)
            super.pressesBegan(presses, withEvent: event)
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animateSpinningDinosaur(0.5, angle: 6.28)
        addBobbingAnimation()
        showInstructionsMomentarily()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override weak var preferredFocusedView: UIView? {
        //        if voiceButton.enabled == true {
        //            return voiceButton
        //        } else {
        return sceneView
        //}
    }
    
    
    
    func setupView() {
        
        soundString = currentDino.previewImageName //make sure mp3 file name is same as image preview name
        nameLabel.text = currentDino.nameString
        descriptionLabel.text = currentDino.descriptionString
        
        
    }
    
    
    func growScoreBar(constraintHeight: CGFloat) {
        goalBarView.shake(10,              // 10 times
            withDelta: 5.0,  // 5 points wide
            speed: 0.03,     // 30ms per shake
            shakeDirection: ShakeDirection.Horizontal
        )
        
        self.goalBarTopConstraint.constant = constraintHeight
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveEaseInOut, animations: { _ in
            
            self.view.layoutIfNeeded()
            }, completion: { _ in
                
        })
        
    }
    
    
    func showInstructionsMomentarily() {
        let originalFrame = instructionView.frame
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveEaseInOut, animations: { _ in
            self.instructionView.frame = CGRect(x: originalFrame.origin.x, y: originalFrame.origin.y - 150, width: originalFrame.width, height: originalFrame.height)
            }, completion: { _ in
                UIView.animateWithDuration(0.5, delay: 5.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: .CurveEaseInOut, animations: { _ in
                    self.instructionView.frame = originalFrame
                    }, completion: { _ in
                        
                })
        })
        
    }
    
    
    
    
    func getRootNode() {
        sceneView.scene = SCNScene(named: currentDino.sceneKitString)
        guard let node = sceneView.scene?.rootNode
            else {
                return
        }
        self.currentDinoNode = node //save copy of current dino node
    }
    
    func animateSpinningDinosaur(duration: Double, angle: CGFloat) {
        sceneView.allowsCameraControl = false
        let rotateByAxisAction = SCNAction.rotateByAngle(angle, aroundAxis: SCNVector3.init(0, 1, 0), duration: duration)
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
    
    func playSound(mp3FileName: String) {
        //        if let soundURL = NSBundle.mainBundle().URLForResource(mp3FileName, withExtension: "mp3") {
        //            var thisSound: SystemSoundID = 0
        //            AudioServicesCreateSystemSoundID(soundURL, &thisSound)
        //            // Play
        //            AudioServicesPlaySystemSound(thisSound)
        //        }
        
        if let path = NSBundle.mainBundle().pathForResource(mp3FileName, ofType:"mp3") {
            let fileURL = NSURL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOfURL: fileURL)
                player.prepareToPlay()
                player.delegate = self
                player.play()
                self.isPlayingVoice = true
            }
            catch {
                print("Error getting the audio file")
            }
        }
        
    }
    
    
    func stopSound() {
        
        player.stop()
        self.isPlayingVoice = false
    }
    
    func playNarration() {
        playSound(soundString)
    }
    
    func stopNarration() {
        stopSound()
    }
    
    
    
    func tappedFeedButton() {
        getRootNode()
        
        addBobbingAnimation()
        
        //add new food label
        let xValueArray = [888, 1100, 1200, 1300, 1400, 1500, 1600, 1700] //randomly drop food from different locations
        let randomXIndex = Int(arc4random_uniform(UInt32(xValueArray.count)))
        let tempFoodLabel = UILabel(frame: CGRect(x: xValueArray[randomXIndex], y: -100, width: 145, height: 101))
        
        //randomize font size
        let sizeArray: [CGFloat] = [90, 80, 70, 60, 50, 40] //randomly drop food to different distances
        let randomSizeIndex = Int(arc4random_uniform(UInt32(sizeArray.count)))
        let randomFontSize = sizeArray[randomSizeIndex]
        tempFoodLabel.font = UIFont.systemFontOfSize(randomFontSize)
        
        tempFoodLabel.text = currentDino.foodString
        self.view.addSubview(tempFoodLabel)
        
        
        let yValueArray: [CGFloat] = [500, 400, 600, 700, 800] //randomly drop food to different distances
        let randomYIndex = Int(arc4random_uniform(UInt32(yValueArray.count)))
        let randomYDistance = yValueArray[randomYIndex]
        let oldFrame = tempFoodLabel.frame
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .CurveEaseOut, animations: { _ in
            
            tempFoodLabel.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y + randomYDistance, width: oldFrame.width, height: oldFrame.height)
            
            }, completion: { _ in
                
                //show goal view
                self.goalBarTrailingConstraint.constant = 31
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveEaseInOut, animations: { _ in
                    self.view.layoutIfNeeded()
                    
                    }, completion: { _ in
                        //increase health bar
                        if self.healthHeightLevel >= 217 {
                            self.healthHeightLevel = self.healthHeightLevel - 20
                            self.growScoreBar(self.healthHeightLevel)
                            //play random eating sound
                            let array = ["eating", "eating_2", "eating_3"]
                            let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                            self.sceneView.shake(10,              // 10 times
                                withDelta: 5.0,  // 5 points wide
                                speed: 0.03,     // 30ms per shake
                                shakeDirection: ShakeDirection.Horizontal
                            )
                            self.playSound(array[randomIndex])
                        }
                        else {
                            //flash orange if health bar full
                            self.goalBarView.shake(10,              // 10 times
                                withDelta: 5.0,  // 5 points wide
                                speed: 0.03,     // 30ms per shake
                                shakeDirection: ShakeDirection.Vertical
                            )
                            UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveLinear, animations: { _ in
                                self.goalBarView.backgroundColor = UIColor ( red: 0.9618, green: 0.5325, blue: 0.0325, alpha: 1.0 )
                                }, completion: { _ in
                                    UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveLinear, animations: { _ in
                                        self.healthLabel.text = "Full!"
                                        self.goalBarView.backgroundColor = UIColor ( red: 0.9753, green: 0.7408, blue: 0.036, alpha: 1.0 )
                                        }, completion: { _ in
                                            //play random eating sound
                                            let growlArray = ["trex_growl2", "velociraptor_growl", "trex_growl", "dinosaur_growl"]
                                            let randomGrowlIndex = Int(arc4random_uniform(UInt32(growlArray.count)))
                                            self.playSound(growlArray[randomGrowlIndex])
                                            
                                    })
                            })
                            
                        }
                        //hide goal view
//                        self.goalBarTrailingConstraint.constant = -59
//                        UIView.animateWithDuration(0.5, delay: 1.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveEaseInOut, animations: { _ in
//                            self.view.layoutIfNeeded()
//                            
//                            }, completion: { _ in
//                                
//                        })
                })
                
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveLinear, animations: { _ in
                    tempFoodLabel.alpha = 0.0
                    
                    
                    }, completion: { _ in
                        tempFoodLabel.removeFromSuperview()
                        //self.sceneView.scene = SCNScene(named: self.currentDino.sceneKitString)  //replay actions
                        //rotate dino after feeding
                        self.animateSpinningDinosaur(0.8, angle: 12.57)
                        
                })
                
                
        })
    }
    
    
    
    
    
}


extension DinoDetailViewController: AVAudioPlayerDelegate {
    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if flag == true {
            stopNarration()
        }
    }
}

