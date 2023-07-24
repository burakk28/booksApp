//
//  AuthViewModel.swift
//  booksApp
//
//  Created by Burak Kara on 19.07.2023.
//

import UIKit
import Firebase

class AuthViewModel {
  
    func login(authModel: AuthModel, completion: @escaping (Bool, String?) -> Void) {
      Auth.auth().signIn(withEmail: authModel.email!, password: authModel.password!) { (result, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, nil)
            }
        }
    }
    func register(authModel: AuthModel, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: authModel.email!, password: authModel.password!) { (result, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, nil)
            }
        }
    }
  func logOut(){
    do {
      try Auth.auth().signOut()
    }catch {
      print(error.localizedDescription)
    }
  }
}
