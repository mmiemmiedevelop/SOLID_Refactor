//
//  ActivityIndicator.swift
//  SOLID
//
//  Created by Mac on 3/31/25.
//

import UIKit

class ActivityIndicatorHelper {
    static let shared = ActivityIndicatorHelper()
    private var activityIndicator: UIActivityIndicatorView?
    private init() {}

    func setUp(in view: UIView) {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        self.activityIndicator = indicator
    }
    
    func show() {
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
        }
    }

    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
        }
    }
}
