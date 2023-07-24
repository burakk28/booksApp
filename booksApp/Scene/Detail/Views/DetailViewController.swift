//
//  DetailViewController.swift
//  booksApp
//
//  Created by Burak Kara on 10.07.2023.
//

import UIKit
import SDWebImage
import CoreData
import Firebase

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel?
    var id = Auth.auth().currentUser?.uid ?? ""
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailAuthorLabel: UILabel!
    @IBOutlet weak var detailPublishedDateLabel: UILabel!
    @IBOutlet weak var detailLanguageLabel: UILabel!
    @IBOutlet weak var detailPageCountLabel: UILabel!
    @IBOutlet weak var detailAboutTextView: UITextView!
    @IBOutlet weak var detailFavBtn: UIButton!
  
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        if let viewModel = viewModel {
          if let thumbnailURLString = viewModel.imageThumbnailURL,
             let thumbnailURL = URL(string: thumbnailURLString) {
              detailImageView.sd_setImage(with: thumbnailURL, completed: nil)
          }else {
            detailImageView.image = UIImage(named: "notImage")
          }
            detailTitleLabel.text = viewModel.title 
            detailAuthorLabel.text = viewModel.author
            detailPublishedDateLabel.text = viewModel.publishedDate
            detailLanguageLabel.text = viewModel.language
            detailPageCountLabel.text = "\(viewModel.pageCount)"
            detailAboutTextView.text = viewModel.aboutText
            updateFavButton()
        }
    }
  override func viewWillAppear(_ animated: Bool) {
    updateFavButton()
  }
  
     @IBAction func detailFavBtn(_ sender: UIButton) {
    
      guard let viewModel = viewModel else { return }
    
       if CoreDataHelpers.shared.isFavorite(id: id, title: viewModel.title) {
         CoreDataHelpers.shared.removeFavorite(id: id, title: viewModel.title)
            } else {
              CoreDataHelpers.shared.addFavorite(id: id, title: viewModel.title, author: viewModel.author, imageName: viewModel.imageThumbnailURL)
            }
            updateFavButton()
   }

  func updateFavButton() {
          let isFavorite = CoreDataHelpers.shared.isFavorite(id: id, title: viewModel?.title ?? "")
          let imageName = isFavorite ? "heart.fill" : "heart"
          let image = UIImage(systemName: imageName)
          detailFavBtn.setImage(image, for: .normal)
      }
  }
