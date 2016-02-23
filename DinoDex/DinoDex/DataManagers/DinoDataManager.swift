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
    
    var dinoArray: [Dinosaur] = [
        Dinosaur(name: "Velociraptor", imagePreviewString: "Raptor", description: "Velociraptor was a mid-sized dromaeosaurid, with adults measuring up to 2.07 m (6.8 ft) long, 0.5 m (1.6 ft) high at the hip, and weighing up to 15 kg (33 lb). The skull, which grew up to 25 cm (10 in) long, was uniquely up-curved, concave on the upper surface and convex on the lower. The jaws were lined with 26–28 widely spaced teeth on each side, each more strongly serrated on the back edge than the front.", sceneName: "Raptor.scn"),
        Dinosaur(name: "Tyrannosaurus Rex", imagePreviewString: "Trex", description: "Tyrannosaurus rex was one of the largest land carnivores of all time; the largest complete specimen, located at the Field Museum of Natural History under the name FMNH PR2081 and nicknamed Sue, measured 12.3 meters (40 ft) long, and was 4 meters (13 ft) tall at the hips. Mass estimates have varied widely over the years, from more than 7.2 metric tons (7.9 short tons), to less than 4.5 metric tons (5.0 short tons), with most modern estimates ranging between 5.4 metric tons (6.0 short tons) and 6.8 metric tons (7.5 short tons). One study in 2011 found that the maximum weight of Sue, the largest Tyrannosaurus, was between 9.5 and 18.5 metric tons (9.3–18.2 long tons; 10.5–20.4 short tons), though the authors stated that their upper and lower estimates were based on models with wide error bars and that they consider [them] to be too skinny, too fat, or too disproportionate. Packard et al. tested dinosaur mass estimation procedures on elephants and concluded that those of dinosaurs are flawed and produce over-estimations; thus, the weight of Tyrannosaurus could have been much less than previously thought. Other estimations have concluded that the largest known Tyrannosaurus specimens had masses approaching or exceeding 9 tons.", sceneName: "trex.scn")
    ]
    
    var dinoDLCArray: [Dinosaur] = [
        Dinosaur(name: "Spinosaurus", imagePreviewString: "Spinosaurus", description: "Spinosaurus was among the largest of all known carnivorous dinosaurs, possibly larger than Tyrannosaurus and Giganotosaurus. Estimates published in 2005, 2007, and 2008 suggested that it was between 12.6–18 meters (41–59 ft) in length and 7 to 20.9 tonnes (7.7 to 23.0 short tons) in weight. A new estimate published in 2014 and based on a more complete specimen, supported the earlier research, finding that Spinosaurus could reach lengths greater than 15 m (49 ft). The skull of Spinosaurus was long and narrow, similar to that of a modern crocodilian. Spinosaurus is known to have eaten fish, and most scientists believe that it hunted both terrestrial and aquatic prey; evidence suggests that it lived both on land and in water as a modern crocodilian does. The distinctive spines of Spinosaurus, which were long extensions of the vertebrae, grew to at least 1.65 meters (5.4 ft) long and were likely to have had skin connecting them, forming a sail-like structure, although some authors have suggested that the spines were covered in fat and formed a hump. Multiple functions have been put forward for this structure, including thermoregulation and display.", sceneName: "Spinosaurus.scn"),
        Dinosaur(name: "Triceratops", imagePreviewString: "trike", description: "Individual Triceratops are estimated to have reached about 7.9 to 9.0 m (26.0–29.5 ft) in length, 2.9 to 3.0 m (9.5 to 9.8 ft) in height, and 6.1–12.0 tonnes (13,000–26,000 lb) in weight. The most distinctive feature is their large skull, among the largest of all land animals. The largest known skull (specimen MWC 7584, formerly BYU 12183) is estimated to have been 2.5 metres (8.2 ft) in length when complete, and could reach almost a third of the length of the entire animal. It bore a single horn on the snout, above the nostrils, and a pair of horns approximately 1 m (3.3 ft) long, with one above each eye. In 2010, paleontologists revealed a fossil (named \"Yoshi's Trike\" MOR 3027) with 115 cm long horn cores, housed and displayed at the Museum of the Rockies in Montana. To the rear of the skull was a relatively short, bony frill, adorned with epoccipitals in some specimens. Most other ceratopsids had large fenestrae in their frills, while those of Triceratops were noticeably solid.", sceneName: "trike.scn")
    ]
    
    
    
    
}