//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by Wayne Rumble on 09/12/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
    
    var photos = [Photo]()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "PhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
        let  photo = photos[indexPath.row]
        cell.updateWithImage(photo.image)
        return cell
    }
}
