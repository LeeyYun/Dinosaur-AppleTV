//
//  Dinosaur.swift
//  DinoDex
//
//  Created by Nathan Hekman on 1/20/16.
//  Copyright © 2016 NTH. All rights reserved.
//

import UIKit

class Dinosaur: NSObject {
    var nameString: String!
    var descriptionString: String!
    var sceneKitString: String!
    
    
    init(name: String!, description: String!, sceneName: String!){
        self.nameString = name
        self.descriptionString = description
        self.sceneKitString = sceneName
    }
}
