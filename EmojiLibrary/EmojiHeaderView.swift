//
//  EmojiHeaderView.swift
//  EmojiLibrary
//
//  Created by Muhammad Fawwaz Mayda on 23/05/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class EmojiHeaderView : UICollectionReusableView {
    
    @IBOutlet weak var textLabel: UILabel!
    
    static let reuseIdentifier = String(describing: EmojiHeaderView.self)
}
