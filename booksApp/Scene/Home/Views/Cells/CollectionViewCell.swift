//
//  CollectionViewCell.swift
//  booksApp
//
//  Created by Burak Kara on 6.07.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var collectionImageView: UIImageView!
  @IBOutlet weak var collectionTitleLabel: UILabel!
  @IBOutlet weak var collectionAuthorsLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }

}
