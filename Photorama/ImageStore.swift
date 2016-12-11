//
//  ImageStore.swift
//  Homepwner
//
//  Created by Wayne Rumble on 14/09/2016.
//  Copyright © 2016 Smile Machine. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key)
        
        let imageURL = imageURLForKey(key)
        
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            data.writeToURL(imageURL, atomically: true)
        }
    }
    
    func imageForKey(key: String) -> UIImage? {
        if let existingImage = cache.objectForKey(key) as? UIImage {
            return existingImage
        }
        let imageURL = imageURLForKey(key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path!) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key)
        return imageFromDisk
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObjectForKey(key)
        
        let imageURL = imageURLForKey(key)
        do {
            try NSFileManager.defaultManager().removeItemAtURL(imageURL)
        } catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
    }
    
    func imageURLForKey(key: String) -> NSURL {
        
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.URLByAppendingPathComponent(key)
    }
}
