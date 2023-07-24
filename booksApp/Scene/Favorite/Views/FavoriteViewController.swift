//
//  FavViewController.swift
//  booksApp
//
//  Created by Burak Kara on 18.07.2023.
//

import UIKit
import CoreData
import SDWebImage
import Firebase

class FavoriteViewController: UIViewController {
  
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = FavoriteViewModel()
    var id = Auth.auth().currentUser?.uid ?? ""

    override func viewDidLoad() {
    super.viewDidLoad()
          viewModel.getCoreData(forUserID: id)
          collectionView.reloadData()
          collectionView.register(UINib(nibName: "FavCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "favCell")
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      viewModel.getCoreData(forUserID: id)
        collectionView.reloadData()
    }
}

extension FavoriteViewController: UICollectionViewDataSource ,FavCollectionViewCellDelegate {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      viewModel.numberOfFavorites
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! FavCollectionViewCell
      cell.delegate = self
      let favorite = viewModel.favorite(at: indexPath.row)
      let imageURL = URL(string: favorite.imageName ?? "")
      cell.favImageView.sd_setImage(with: imageURL)
      cell.favTitleLabel.text = favorite.title
      return cell
    }
  
    func removeFromFavorites(cell: FavCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let favorite = viewModel.favorite(at: indexPath.row)

      Common().showAlert(title: "Confirmation", message: "Are you sure you want to delete from favourite?", showCancel:true, vc: self,onCancel: {
            print("Cancel")
        }) {
          CoreDataHelpers.shared.removeFavorite(id: self.id, title: favorite.title ?? "")
          self.viewModel.getCoreData(forUserID: self.id)
          self.collectionView.reloadData()
        }
    }
}


