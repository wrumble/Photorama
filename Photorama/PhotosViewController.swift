//
//  ViewController.swift
//  Photorama
//
//  Created by Wayne Rumble on 07/12/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var store: Photostore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchRecentPhotos() { (photosResult) -> Void in
            switch photosResult {
            case let .Success(photos):
                print("Succesfully found \(photos.count) recent photos.")
                
                if let firstPhoto = photos.first {
                    self.store.fetchImageForPhoto(firstPhoto) {
                        (imageResult) -> Void in
                        
                        switch imageResult {
                        case let .Success(image):
                            NSOperationQueue.mainQueue().addOperationWithBlock {
                                self.imageView.image = image
                            }
                        case let .Failure(error):
                            print("Error downloading image: \(error)")
                        }
                    }
                }
            case let .Failure(error):
                print("Error fetching recent photos: \(error)")
            }
        }
    }

}

