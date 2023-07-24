//
//  RegisterViewController.swift
//  booksApp
//
//  Created by Burak Kara on 19.07.2023.
//

import UIKit

class RegisterViewController: UIViewController {
  
  private let viewModel = AuthViewModel()
  @IBOutlet weak var emailTxt: UITextField!
  @IBOutlet weak var passwordTxt: UITextField!
  @IBOutlet weak var passwordRepeatTxt: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }

  @IBAction func registerBtn(_ sender: Any) {
    
    let email = emailTxt.text ?? ""
    let password = passwordTxt.text ?? ""
    let passwordRepeat = passwordRepeatTxt.text ?? ""
    let authModel = AuthModel(email: email, password: password)
    
    if email.isEmpty || password.isEmpty || password != passwordRepeat {
      Common().showAlert(title: "Warning!", message: "Check Email and Password", showCancel: false, vc: self)
      return
    }
    else {
      viewModel.register(authModel: authModel) { success, error in
        if success {
          Common().showBackAlert(title: "Success", message: "Register Created", vc: self)
        }else {
          Common().showAlert(title: "Warning!", message: error!, showCancel: false, vc: self)
        }
      }
    }
  }
}
