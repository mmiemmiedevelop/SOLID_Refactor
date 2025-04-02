//
//  ErrorAlert.swift
//  SOLID
//
//  Created by Mac on 4/1/25.
//

import UIKit

class ErrorAlert {
    
    static func show(in viewController: UIViewController, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            viewController.present(alert, animated: true)
        }
    }
    
}
