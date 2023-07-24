//
//  FavCollectionViewCell.swift
//  booksApp
//
//  Created by Burak Kara on 18.07.2023.
//

import UIKit

protocol FavCollectionViewCellDelegate: AnyObject {
    func removeFromFavorites(cell: FavCollectionViewCell)
}

class FavCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var favImageView: UIImageView!
  @IBOutlet weak var favTitleLabel: UILabel!
  
  weak var delegate: FavCollectionViewCellDelegate?
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  @IBAction func favBtn(_ sender: Any) {
    delegate?.removeFromFavorites(cell: self)
  }
}
