//
//  LoginViewController.swift
//  booksApp
//
//  Created by Burak Kara on 19.07.2023.
//

import UIKit

class LoginViewController: UIViewController {
  
  private let viewModel = AuthViewModel()
  @IBOutlet weak var emailTxt: UITextField!
  @IBOutlet weak var passwordTxt: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  @IBAction func loginBtn(_ sender: Any) {
    
    let email = emailTxt.text ?? ""
    let password = passwordTxt.text ?? ""
    let authModel = AuthModel(email: email, password: password)
    
    if email.isEmpty || password.isEmpty {
      Common().showAlert(title: "Warning!", message: "Email/Password Cannot Be Empty", showCancel: false, vc: self)
    }else {
      viewModel.login(authModel: authModel) { success, error in
        if success {
          self.performSegue(withIdentifier: "toMain", sender: nil)
        }else {
          Common().showAlert(title: "Warning!", message: "Check Email/Password", showCancel: false, vc: self)
        }
      }
    }
  }
}
