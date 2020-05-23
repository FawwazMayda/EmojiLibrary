//
//  DataSource.swift
//  EmojiLibrary
//
//  Created by Muhammad Fawwaz Mayda on 23/05/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class DataSource : NSObject, UICollectionViewDataSource {
    let emoji = Emoji.shared
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emoji.data.keys.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionEmoji = self.emoji.sections[section]
        let emojiInSection = self.emoji.data[sectionEmoji]?.count
        return emojiInSection ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else {
            fatalError("Cell can't be created")
        }
        let section = self.emoji.sections[indexPath.section]
        emojiCell.emojiLabel.text = self.emoji.data[section]?[indexPath.item]
        return emojiCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiHeaderView.reuseIdentifier, for: indexPath) as? EmojiHeaderView else {
            fatalError("Cant instatiate Header")
        }
        cell.textLabel.text = self.emoji.sections[indexPath.section].rawValue
        return cell
    }
}

extension DataSource {
    func addEmoji(newEmoji emoji:String, to category: Emoji.Category) {
        guard var emojiData = self.emoji.data[category] else {
            fatalError("Invalid Emoji Key")
        }
        emojiData.append(emoji)
        self.emoji.data.updateValue(emojiData, forKey: category)
    }
    
    func deleteEmoji(for indexPath : IndexPath) {
        let sectionEmoji = self.emoji.sections[indexPath.section]
        self.emoji.data[sectionEmoji]?.remove(at: indexPath.item)
    }
    
    func deleteEmoji(for indexPath: [IndexPath]) {
        for index in indexPath {
            self.deleteEmoji(for: index)
        }
    }
    
}
