//
//  FirstViewController.swift
//  DinoDex
//
//  Created by Nathan Hekman on 1/18/16.
//  Copyright © 2016 NTH. All rights reserved.
//

import UIKit
import SceneKit
import AVFoundation

class FirstViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var sceneView: SCNView!
    
    var nameString: String!
    var descriptionString: String!
    var sceneKitString: String!
    
    var coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Trex", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if let soundURL = NSBundle.mainBundle().URLForResource("Trex", withExtension: "mp3") {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func playSound() {
        
        
    }
    
    func setupView() {
        nameLabel.text = nameString
        descriptionLabel.text = descriptionString
        sceneView.scene = SCNScene(named: sceneKitString)
        
    }
    
    
}

