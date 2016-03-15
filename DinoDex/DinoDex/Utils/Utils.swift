//
//  Utils.swift
//  Bluemix-Client-OS-X
//
//  Created by Rolando Asmat on 2/8/16.
//  Copyright © 2016 IBM. All rights reserved.
//

import Foundation

class Utils: NSObject {
    
    static let notificationCenter = NSNotificationCenter.defaultCenter() // Notification center for general use.
    
    /**
    Method to update a user defaults key with a string value
    
    - parameter key:         key to save string to
    - parameter message: string to save under key
    */
    class func updateUserDefaultsKeyWithString(key: String, message: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(message, forKey: key)
        userDefaults.synchronize()
        
    }
    
    /**
     Method to retrieve a string value from a key from user defaults
     
     - parameter key: key value to retrieve from
     
     - returns: String value saved under key, or nil if doesn't exist
     */
    class func retrieveStringFromUserDefaultsKey (key: String) -> String? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let chill = userDefaults.valueForKey(key) as? String {
            return chill
        }
        else {
            return nil
        }
        
    }
    
    /**
     Removes the value stored in User Defaults for specified key.
     
     - parameter key: User Defaults key.
     */
    class func clearValueForUserDefaultsKey (key: String) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /**
     Method adds an observer to the notification center
     
     - parameter name:   String?
     - parameter object: AnyObject?
     - parameter block:  (NSNotification!) -> Void
     
     - returns: NSObjectProtocol
     */
    
    class func observe(name: String?, object: AnyObject? = nil, block: (NSNotification!) -> Void) -> NSObjectProtocol {
        let nc = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        return nc.addObserverForName(name, object: object, queue: queue, usingBlock: block)
    }
    
    
}


