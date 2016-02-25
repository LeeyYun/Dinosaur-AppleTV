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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        playSound()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //todo: play correct sound based on perhaps value in current Dinosaur object that contains name of sounds file for playing
    func playSound() {
        if let soundURL = NSBundle.mainBundle().URLForResource("Trex", withExtension: "mp3") {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        }
        
    }
    
    //todo: pass in a Dinosaur object and set it up from this, rather than setting individual labels
    func setupView() {
        nameLabel.text = nameString
        descriptionLabel.text = descriptionString
        sceneView.scene = SCNScene(named: sceneKitString)
        
    }
    
    
}

