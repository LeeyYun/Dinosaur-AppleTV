//
//  PhoneSessionManager.swift
//  DinoDex
//
//  Created by Nathan Hekman on 12/17/15.
//  Copyright © 2015 NTH. All rights reserved.
//

import UIKit

class DinoDataManager: NSObject {
    
    static let sharedInstance: DinoDataManager = {
        var instance = DinoDataManager()
        return instance
        
    }()
    
    
    private override init() {
        super.init()
    }
    
    var dinoArray = [
        Dinosaur(name: "Velociraptor", imagePreviewString: "Raptor", description: "Velociraptor was a mid-sized dromaeosaurid, with adults measuring up to 2.07 m (6.8 ft) long, 0.5 m (1.6 ft) high at the hip, and weighing up to 15 kg (33 lb). The skull, which grew up to 25 cm (10 in) long, was uniquely up-curved, concave on the upper surface and convex on the lower. The jaws were lined with 26–28 widely spaced teeth on each side, each more strongly serrated on the back edge than the front.", sceneName: "Raptor.scn"),
        Dinosaur(name: "Spinosaurus", imagePreviewString: "Spinosaurus", description: "Spinosaurus was among the largest of all known carnivorous dinosaurs, possibly larger than Tyrannosaurus and Giganotosaurus. Estimates published in 2005, 2007, and 2008 suggested that it was between 12.6–18 meters (41–59 ft) in length and 7 to 20.9 tonnes (7.7 to 23.0 short tons) in weight. A new estimate published in 2014 and based on a more complete specimen, supported the earlier research, finding that Spinosaurus could reach lengths greater than 15 m (49 ft). The skull of Spinosaurus was long and narrow, similar to that of a modern crocodilian. Spinosaurus is known to have eaten fish, and most scientists believe that it hunted both terrestrial and aquatic prey; evidence suggests that it lived both on land and in water as a modern crocodilian does. The distinctive spines of Spinosaurus, which were long extensions of the vertebrae, grew to at least 1.65 meters (5.4 ft) long and were likely to have had skin connecting them, forming a sail-like structure, although some authors have suggested that the spines were covered in fat and formed a hump. Multiple functions have been put forward for this structure, including thermoregulation and display.", sceneName: "Spinosaurus.scn")
    ]
    
    
    
    
}