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
    var previewImageName: String!
    
    
    init(name: String!, imagePreviewString: String!, description: String!, sceneName: String!){
        self.nameString = name
        self.previewImageName = imagePreviewString
        self.descriptionString = description
        self.sceneKitString = sceneName
    }
}
