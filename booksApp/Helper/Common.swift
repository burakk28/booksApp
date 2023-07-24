//
//  Common.swift
//  booksApp
//
//  Created by Burak Kara on 18.07.2023.
//

import UIKit
import CoreData

class Common{
    
  func showAlert(title: String, message: String, showCancel:Bool,vc: UIViewController, onCancel: (() -> Void)? = nil, onOK: (() -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let actionOk = UIAlertAction(title: "OK", style: .default) { _ in
          onOK?()
      }
      alert.addAction(actionOk)
      if showCancel {
      let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        onCancel?()
      }
      alert.addAction(actionCancel)
    }
      vc.present(alert, animated: true, completion: nil)
  }
   func showBackAlert(title: String, message: String, vc: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        vc.dismiss(animated: true, completion: nil)
    }
    alert.addAction(okAction)
    vc.present(alert, animated: true, completion: nil)
  }
}
