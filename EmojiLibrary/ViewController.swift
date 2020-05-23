/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var deleteBarButton: UIBarButtonItem!
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    let dataSource = DataSource()
  let delegate = EmojiCollectionViewDelegate(numberOfItemInRow: 8, spacingPerItem: 10)
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.dataSource = dataSource
    self.collectionView.delegate = delegate
    navigationItem.leftBarButtonItem = editButtonItem
    deleteBarButton.isEnabled = false
    collectionView.allowsMultipleSelection = true
    // Do any additional setup after loading the view.
  }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        deleteBarButton.isEnabled = editing
        addBarButton.isEnabled = !editing
        
        collectionView.indexPathsForVisibleItems.forEach {
            guard let emojiCell = collectionView.cellForItem(at: $0) as? EmojiCell else {return}
            emojiCell.isEditing = editing
        }
        
        if !editing {
            collectionView.indexPathsForSelectedItems?.forEach{
                collectionView.deselectItem(at: $0, animated: true)
            }
        }
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier=="showEmojiDetail" && isEditing {
            return false
        } else {
            return true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier=="showEmojiDetail",
            let emojiCell = sender as? EmojiCell,
            let destVC = segue.destination as? EmojiDetailController,
            let indexPath = collectionView.indexPath(for: emojiCell),
            let emoji = Emoji.shared.emoji(at: indexPath)
            else {
            fatalError("Not the right segue")
        }
        destVC.emoji = emoji
    }
    
    @IBAction func addEmoji(_ sender:Any?) {
        let (category,emoji) = Emoji.randomEmoji()
        dataSource.addEmoji(newEmoji: emoji, to: category)
        let emojiNewIndex = collectionView.numberOfItems(inSection: 0)
        let insertedIndexPath = IndexPath(item: emojiNewIndex, section: 0 )
        collectionView.insertItems(at: [insertedIndexPath])
    }
    
    @IBAction func deleteEmoji(_ sender: Any?) {
        guard let selectedIndex = collectionView.indexPathsForSelectedItems else {return}
        let sectionToBeDeleted = Set(selectedIndex.map({ $0.section }))
        sectionToBeDeleted.forEach { (section) in
            let itemToBeDeleted = selectedIndex.filter { (ip) -> Bool in
                ip.section == section
            }
            let itemForDeleted = itemToBeDeleted.sorted(by: {$0.item > $1.item})
            
            dataSource.deleteEmoji(for: itemForDeleted)
            collectionView.deleteItems(at: itemForDeleted)
            
        }
    }
}

