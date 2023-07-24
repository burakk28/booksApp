//
//  TableViewCell.swift
//  booksApp
//
//  Created by Burak Kara on 6.07.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

  @IBOutlet weak var tableImageView: UIImageView!
  @IBOutlet weak var tableTitleLabel: UILabel!
  @IBOutlet weak var tableAuthorsLabel: UILabel!
  @IBOutlet weak var tableDateLabel: UILabel?
  
  override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
    
}
