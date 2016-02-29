//
//  DinoSceneView.swift
//  DinoDex
//
//  Created by Nathan Hekman on 2/29/16.
//  Copyright © 2016 NTH. All rights reserved.
//

import UIKit
import SceneKit

class DinoSceneView: SCNView {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func canBecomeFocused() -> Bool {
        return true
    }
    

}
