//
//  UserViewController.swift
//  booksApp
//
//  Created by Burak Kara on 19.07.2023.
//

import UIKit
import Firebase

class UserViewController: UIViewController {

  private let viewModel = AuthViewModel()
  @IBOutlet weak var emailLbl: UILabel!
  @IBOutlet weak var dateLbl: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    if let currentUser = Auth.auth().currentUser {
      let creationDate = currentUser.metadata.creationDate?.formatted(date: .abbreviated, time: .standard)
      emailLbl.text = "\(currentUser.email!)"
      dateLbl.text = "\(creationDate!)"
      print(currentUser.uid)
      }
    }
    
  @IBAction func darkModeSwitch(_ sender: UISwitch) {
    
    let appDelegate = UIApplication.shared.windows.first
    if sender.isOn {
      appDelegate?.overrideUserInterfaceStyle = .dark
      return
    }
    appDelegate?.overrideUserInterfaceStyle = .light
    return
  }
  @IBAction func logoutBtn(_ sender: Any) {
    
    viewModel.logOut()
    performSegue(withIdentifier: "toLogin", sender: nil)
    
  }
}
