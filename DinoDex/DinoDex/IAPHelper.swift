//  Created by Nathan Hekman on 1/21/16.
//  Copyright © 2016 NTH. All rights reserved.
//

import StoreKit

/// Notification that is generated when a product is purchased.
public let IAPHelperProductPurchasedNotification = "IAPHelperProductPurchasedNotification"

/// Product identifiers are unique strings registered on the app store.
public typealias ProductIdentifier = String

/// Completion handler called when products are fetched.
public typealias RequestProductsCompletionHandler = (success: Bool, products: [SKProduct]) -> ()


/// A Helper class for In-App-Purchases, it can fetch products, tell you if a product has been purchased,
/// purchase products, and restore purchases.  Uses NSUserDefaults to cache if a product has been purchased.
public class IAPHelper : NSObject  {
    
    /// MARK: - Private Properties
    
    // Used to keep track of the possible products and which ones have been purchased.
    private let productIdentifiers: Set<ProductIdentifier>
    private var purchasedProductIdentifiers = Set<ProductIdentifier>()
    
    // Used by SKProductsRequestDelegate
    private var productsRequest: SKProductsRequest?
    private var completionHandler: RequestProductsCompletionHandler?
  
  /// MARK: - User facing API
  
  /// Initialize the helper.  Pass in the set of ProductIdentifiers supported by the app.
  public init(productIdentifiers: Set<ProductIdentifier>) {
    self.productIdentifiers = productIdentifiers
    super.init()
  }
  
    /// Gets the list of SKProducts from the Apple server calls the handler with the list of products.
    public func requestProductsWithCompletionHandler(handler: RequestProductsCompletionHandler) {
        completionHandler = handler
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }

  /// Initiates purchase of a product.
  public func purchaseProduct(product: SKProduct) {
  }
  
  /// Given the product identifier, returns true if that product has been purchased.
  public func isProductPurchased(productIdentifier: ProductIdentifier) -> Bool {
    return false
  }
  
  /// If the state of whether purchases have been made is lost  (e.g. the
  /// user deletes and reinstalls the app) this will recover the purchases.
  public func restoreCompletedTransactions() {
  }
}

// MARK: - SKProductsRequestDelegate

extension IAPHelper: SKProductsRequestDelegate {
    public func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        print("Loaded list of products...")
        let products = response.products
        completionHandler?(success: true, products: products)
        clearRequest()
        
        // debug printing
        for p in products {
            print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
        }
    }
    
    public func request(request: SKRequest, didFailWithError error: NSError) {
        print("Failed to load list of products.")
        print("Error: \(error)")
        clearRequest()
    }
    
    private func clearRequest() {
        productsRequest = nil
        completionHandler = nil
    }
}
