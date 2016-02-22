//
//  CustomFocusEffectsCollectionViewController.swift
//  tvOS-Examples
//
//  Copyright (c) 2016 WillowTree, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//

import UIKit
import SceneKit
import StoreKit

private let reuseIdentifier = "Cell"

class CustomFocusEffectsCollectionViewController: UICollectionViewController {
    
    // This list of available in-app purchases
    var products = [SKProduct]()
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // priceFormatter is used to show proper, localized currency
    lazy var priceFormatter: NSNumberFormatter = {
        let pf = NSNumberFormatter()
        pf.formatterBehavior = .Behavior10_4
        pf.numberStyle = .CurrencyStyle
        return pf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
        // Subscribe to a notification that fires when a product is purchased.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "productPurchased:", name: IAPHelperProductPurchasedNotification, object: nil)
    }
    
    // Fetch the products from iTunes connect, redisplay the table on successful completion
    func reload() {
        products = []
        self.collectionView!.reloadData()
        DinoProducts.store.requestProductsWithCompletionHandler { success, products in
            if success {
                self.products = products
                self.collectionView!.reloadData()
            }
            //self.refreshControl?.endRefreshing()
        }
    }
    

    
    // Purchase the product
    func buyButtonTapped(button: UIButton) {
        let product = products[button.tag]
        DinoProducts.store.purchaseProduct(product)
    }
    
    // When a product is purchased, this notification fires, redraw the correct row
    func productPurchased(notification: NSNotification) {
        let productIdentifier = notification.object as! String
        for (index, product) in products.enumerate() {
            if product.productIdentifier == productIdentifier {
                //self.collectionView!.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Fade)
                self.collectionView?.reloadData()
                break
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DinoDataManager.sharedInstance.dinoArray.count
        //return products.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        if indexPath.row < products.count {
            let product = products[indexPath.row]
            print("\(product.localizedTitle)")
            priceFormatter.locale = product.priceLocale
            print("Formatted price: \(priceFormatter.stringFromNumber(product.price)!)")
        }
        
        if let imageCell = cell as? CustomFocusCell {
            let dinoObject = DinoDataManager.sharedInstance.dinoArray[indexPath.item]
            imageCell.imageView.image = UIImage(named: dinoObject.previewImageName)
            imageCell.titleLabel.text = dinoObject.nameString
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let first = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DinoDetailViewController") as? DinoDetailViewController {
            //setup the dinosaur model and text to show here based on indexpath
            let dinoObject = DinoDataManager.sharedInstance.dinoArray[indexPath.item]
            first.nameString = dinoObject.nameString
            first.descriptionString = dinoObject.descriptionString
            first.sceneKitString = dinoObject.sceneKitString
            self.presentViewController(first, animated: true, completion: nil)
        }
    }
}
