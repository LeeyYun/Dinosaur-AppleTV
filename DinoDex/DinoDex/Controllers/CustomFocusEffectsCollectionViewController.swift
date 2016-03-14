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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "productPurchaseFailed:", name: IAPHelperProductFailedNotification, object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView?.reloadData()
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
                //redraw view showing that product was purchased
                //self.collectionView!.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Fade)
                self.collectionView?.reloadData()
                break
            }
        }
    }
    
    // When a product is purchased, this notification fires, redraw the correct row
    func productPurchaseFailed(notification: NSNotification) {
        let productIdentifier = notification.object as! String
        for (index, product) in products.enumerate() {
            if product.productIdentifier == productIdentifier {
                print("Received notification couldn't purchase \(productIdentifier)")
                //redraw view showing that product failed purchasing
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
        return DinoDataManager.sharedInstance.dinoArray.count + products.count
        //return products.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        
        
        if let imageCell = cell as? CustomFocusCell {
            if indexPath.row < (DinoDataManager.sharedInstance.dinoArray.count) {
                let dinoObject = DinoDataManager.sharedInstance.dinoArray[indexPath.item]
                imageCell.imageView.image = UIImage(named: dinoObject.previewImageName)
                imageCell.titleLabel.text = dinoObject.nameString
                imageCell.setPurchasedState()
            }
            //show dlc
            if indexPath.row > (DinoDataManager.sharedInstance.dinoArray.count - 1) {
                let relativeProductInt = indexPath.row - (DinoDataManager.sharedInstance.dinoArray.count - 1)
                let product = products[relativeProductInt - 1]
                print("\(product.localizedTitle)")
                priceFormatter.locale = product.priceLocale
                let numberAsString = priceFormatter.stringFromNumber(product.price)!
                print("Formatted price: \(numberAsString)")
                
                //should maybe lookup Dinosaur DLC object in data manager and display details
                for dinoObject in DinoDataManager.sharedInstance.dinoDLCArray {
                    if dinoObject.nameString == product.localizedTitle {
                        imageCell.imageView.image = UIImage(named: dinoObject.previewImageName)
                        imageCell.titleLabel.text = dinoObject.nameString!
                        print("setup cell for DLC - \(dinoObject.nameString)")
                    }
                }
                
                
                // check status of product sale
                if DinoProducts.store.isProductPurchased(product.productIdentifier) {
                    //update cell to show it's purchased
                    imageCell.setPurchasedState()
                }
                else if IAPHelper.canMakePayments() {
                    //setup cell for "Buy" state, so user can buy this new content
                    let oldText = imageCell.titleLabel.text!
                    imageCell.titleLabel.text = "\(oldText) - \(numberAsString)"
                    imageCell.setDLCState()
                }
                else {
                    //state not found, maybe don't display cell
                }
                
                
            }
            
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.row < products.count {
//            let product = products[indexPath.row]
//            DinoProducts.store.purchaseProduct(product)
//        }
        
        //unlocked content
        if indexPath.row < (DinoDataManager.sharedInstance.dinoArray.count) {
            if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DinoDetailViewController") as? DinoDetailViewController {
                //setup the dinosaur model and text to show here based on indexpath
                let dinoObject = DinoDataManager.sharedInstance.dinoArray[indexPath.item]
                //send the dino object to the view to setup itself
                detailVC.currentDino = dinoObject
                self.presentViewController(detailVC, animated: true, completion: nil)
            }
        }
        //show dlc
        if indexPath.row > (DinoDataManager.sharedInstance.dinoArray.count - 1) {
            let relativeProductInt = indexPath.row - (DinoDataManager.sharedInstance.dinoArray.count - 1)
            let product = products[relativeProductInt - 1]
            //maybe check if purchased before purchasing?
            
            
            // check status of product sale
            if DinoProducts.store.isProductPurchased(product.productIdentifier) {
                //allow user to see details if purchased
                for dinoObject in DinoDataManager.sharedInstance.dinoDLCArray {
                    if dinoObject.nameString == product.localizedTitle {
                        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DinoDetailViewController") as? DinoDetailViewController {
                            //send the dino object to the view to setup itself
                            detailVC.currentDino = dinoObject
                            self.presentViewController(detailVC, animated: true, completion: nil)
                        }
                    }
                }
            }
            else if IAPHelper.canMakePayments() {
                //setup cell for "Buy" state, so user can buy this new content
                DinoProducts.store.purchaseProduct(product)
            }
            else {
                //state not found, maybe don't display cell
            }
            
            
            
        }

    }
}
