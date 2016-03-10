//  Created by Nathan Hekman on 1/21/16.
//  Copyright © 2016 NTH. All rights reserved.
//

import Foundation

// Use enum as a simple namespace.  (It has no cases so you can't instantiate it.)
public enum DinoProducts {
    
    /// TODO:  Change this to whatever you set on iTunes connect
    private static let Prefix = "org.NTH.dinosaurs."
    
    /// MARK: - Supported Product Identifiers
    public static let Spinosaurus = Prefix + "spinosaurus"
    public static let Triceratops = Prefix + "triceratops"
    public static let Brachiosaurus = Prefix + "brachiosaurus"
    //add others here
    
    
    // All of the products assembled into a set of product identifiers.
    private static let productIdentifiers: Set<ProductIdentifier> = [DinoProducts.Spinosaurus, DinoProducts.Triceratops, DinoProducts.Brachiosaurus]//add others separated by comma
    
    /// Static instance of IAPHelper that for rage products.
    public static let store = IAPHelper(productIdentifiers: DinoProducts.productIdentifiers)
}

/// Return the resourcename for the product identifier.
func resourceNameForProductIdentifier(productIdentifier: String) -> String? {
    return productIdentifier.componentsSeparatedByString(".").last
}