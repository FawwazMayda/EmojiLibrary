//
//  EmojiCollectionViewDelegate.swift
//  EmojiLibrary
//
//  Created by Muhammad Fawwaz Mayda on 23/05/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class EmojiCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    let numberOfItemInRow : CGFloat
    let spacingPerItem : CGFloat
    init(numberOfItemInRow : CGFloat, spacingPerItem: CGFloat) {
        self.spacingPerItem = spacingPerItem; self.numberOfItemInRow = numberOfItemInRow
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth = UIScreen.main.bounds.width
        let totalSpacing = self.numberOfItemInRow * self.spacingPerItem
        let itemWidth = (maxWidth - totalSpacing) / self.numberOfItemInRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.spacingPerItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section==0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: self.spacingPerItem/2, right: 0)
        } else {
            return UIEdgeInsets(top: self.spacingPerItem/2, left: 0, bottom: self.spacingPerItem/2, right: 0)
        }
    }
    
}

extension EmojiCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

