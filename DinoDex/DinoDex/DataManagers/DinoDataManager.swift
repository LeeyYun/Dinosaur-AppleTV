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
    
    //todo: come up with readable descriptions, maybe include food they ate?
    //todo 2: decide number of included and dlc dinos
    
    var dinoArray: [Dinosaur] = [
        Dinosaur(
            name: "Velociraptor",
            imagePreviewString: "Raptor",
            description: "Velociraptor was a mid-sized dromaeosaurid, with adults measuring up to 2.07 m (6.8 ft) long, 0.5 m (1.6 ft) high at the hip, and weighing up to 15 kg (33 lb). The skull, which grew up to 25 cm (10 in) long, was uniquely up-curved, concave on the upper surface and convex on the lower. The jaws were lined with 26–28 widely spaced teeth on each side, each more strongly serrated on the back edge than the front.\n\nThe name Velociraptor is derived from the Latin words velox ('swift') and raptor ('robber' or 'plunderer') and refers to the animal's cursorial nature and carnivorous diet.",
            sceneName: "Raptor.scn",
            foodEmojiString: "🍗"),
        Dinosaur(
            name: "Tyrannosaurus Rex",
            imagePreviewString: "Trex",
            description: "Tyrannosaurus Rex was one of the largest land carnivores of all time; the largest complete specimen, located at the Field Museum of Natural History under the name FMNH PR2081 and nicknamed Sue, measured 12.3 meters (40 ft) long, and was 4 meters (13 ft) tall at the hips.\n\nMost paleontologists accept that Tyrannosaurus was both an active predator and a scavenger like most large carnivores. Tyrannosaurus may have even had infectious saliva used to kill its prey.",
            sceneName: "trex.scn",
            foodEmojiString: "🍖"),
        Dinosaur(
            name: "Stegosaurus",
            imagePreviewString: "Stegosaurus",
            description: "Stegosaurus was a large, heavily built, herbivorous quadrupedal animal with rounded backs, short fore limbs, long hind limbs, and tails held high in the air. Due to their distinctive combination of broad, upright plates and tail tipped with spikes, Stegosaurus is one of the most recognizable kinds of dinosaur. The function of this array of plates and spikes has been the subject of much speculation among scientists. Today, it is generally agreed that their spikes were most likely used for defense against predators, while their plates may have been used primarily for display, and secondarily for thermoregulatory functions.\n\nStegosaurus had short necks and small heads, meaning they most likely ate low-lying bushes and shrubs.",
            sceneName: "stegosaurus.scn",
            foodEmojiString: "🌳")
    ]
    
    var dinoDLCArray: [Dinosaur] = [
        Dinosaur(
            name: "Brachiosaurus",
            imagePreviewString: "brach",
            description: "Brachiosaurus was a quadrupedal animal with a small skull, a long neck, a large trunk with a high-ellipsoid cross section, a long, muscular tail and slender, columnar limbs. The skull had a robust, wide muzzle and thick jaw bones, with spoon–shaped teeth.\n\nIts diet likely consisted of ginkgos, conifers, tree ferns, and large cycads, with intake estimated at 200 to 400 kilograms (440 to 880 lb) of plant matter daily. Brachiosaur feeding involved simple up–and–down jaw motion. The teeth were arranged to shear material as they closed, and were probably used to crop and/or nip vegetation.",
            sceneName: "Brac.scn",
            foodEmojiString: "🌲"),
        Dinosaur(
            name: "Spinosaurus",
            imagePreviewString: "Spinosaurus",
            description: "Spinosaurus was among the largest of all known carnivorous dinosaurs, possibly larger than Tyrannosaurus and Giganotosaurus. Estimates published in 2005, 2007, and 2008 suggested that it was between 12.6–18 meters (41–59 ft) in length and 7 to 20.9 tonnes in weight. The skull of Spinosaurus was long and narrow, similar to that of a modern crocodilian. The distinctive spines of Spinosaurus, which were long extensions of the vertebrae, grew to at least 1.65 meters (5.4 ft) long and were likely to have had skin connecting them, forming a sail-like structure, although some authors have suggested that the spines were covered in fat and formed a hump. Multiple functions have been put forward for this structure, including thermoregulation and display.\n\nSpinosaurus is known to have eaten fish, and most scientists believe that it hunted both terrestrial and aquatic prey; evidence suggests that it lived both on land and in water as a modern crocodilian does.",
            sceneName: "Spinosaurus.scn",
            foodEmojiString: "🐟"),
        Dinosaur(
            name: "Triceratops",
            imagePreviewString: "trike",
            description: "Individual Triceratops are estimated to have reached about 7.9 to 9.0 m (26.0–29.5 ft) in length, 2.9 to 3.0 m (9.5 to 9.8 ft) in height, and 6.1–12.0 tonnes (13,000–26,000 lb) in weight. The most distinctive feature is their large skull, among the largest of all land animals. The largest known skull is estimated to have been 2.5 metres (8.2 ft) in length when complete, and could reach almost a third of the length of the entire animal. It bore a single horn on the snout, above the nostrils, and a pair of horns approximately 1 m (3.3 ft) long, with one above each eye. To the rear of the skull was a relatively short, bony frill, adorned with epoccipitals in some specimens.\n\nTriceratops were herbivorous, and because of their low head, their primary food was probably low growth, although they may have been able to knock down taller plants with their horns, beak, and bulk. The jaws were tipped with a deep, narrow beak, believed to have been better at grasping and plucking than biting.",
            sceneName: "trike.scn",
            foodEmojiString: "🌿"),
        Dinosaur(
            name: "Compsognathus",
            imagePreviewString: "Compy",
            description: "Compsognathus (\"elegant\" or \"dainty\", and \"jaw\") is a genus of small, bipedal, carnivorous theropod dinosaurs. For decades, Compsognathus were famed as the smallest dinosaurs known; the first specimen collected was around 1 m (3 ft) in length. They had long hind legs and longer tails, which they used for balance during locomotion. The forelimbs were smaller than the hindlimbs and featured three digits equipped with solid claws suited for grasping prey.\n\nThe teeth were small but sharp, suited for its diet of small vertebrates and possibly other small animals, such as insects.",
            sceneName: "Compy.scn",
            foodEmojiString: "🐞")
    ]
    
    
    
    
}