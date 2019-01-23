//
//  UICollectionView.swift
//  Contacts
//
//  Created by v.ampilogov on 17/01/2019.
//

import UIKit

extension UICollectionView {
    
    var flowLayout: UICollectionViewFlowLayout? {
        return collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    var centerPoint : CGPoint {
        return CGPoint(x: center.x + contentOffset.x, y: center.y + contentOffset.y);
    }
    
    var centerIndexPath: IndexPath? {
        return indexPathForItem(at: centerPoint)
    }
    
    var centerCell: UICollectionViewCell? {
        guard let indexPath = centerIndexPath else { return nil }
        return cellForItem(at: indexPath)
    }
}

