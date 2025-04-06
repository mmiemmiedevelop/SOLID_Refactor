//
//  DetailViewController.swift
//  SOLID
//
//  Created by Mac on 3/31/25.
//

import UIKit
import CoreImage

class DetailViewController: UIViewController {
    
    var passedPiture: Picture?
    var viewModel = DetailViewModel()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var colorToggle: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicatorHelper.shared.setUp(in: self.view)
        bindViewModel()
        viewModel.loadImage(from: passedPiture!.download_url)
        //줌, 회전기능
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(pinchGesture)
        imageView.addGestureRecognizer(rotationGesture)
        //흑백 토글기능
        colorToggle.addTarget(self, action: #selector(toggleImageColor), for: .valueChanged)
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.imageView.image = self?.viewModel.originalImage
            }
        }
        
        viewModel.onLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                if let view = self?.view {
                    isLoading ? ActivityIndicatorHelper.shared.show() : ActivityIndicatorHelper.shared.hide()
                }
            }
        }
        
        viewModel.onError = { [weak self] errorMsg in
            guard let self = self else { return }
            ErrorAlert.show(in: self, message: errorMsg)
        }
    }
    
    // MARK: - 줌 기능
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let view = gesture.view else { return }
        if gesture.state == .began || gesture.state == .changed {
            view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
            gesture.scale = 1.0
        }
    }
    
    // MARK: - 회전 기능
    @objc func handleRotation(_ gesture: UIRotationGestureRecognizer) {
        guard let view = gesture.view else { return }
        if gesture.state == .began || gesture.state == .changed {
            view.transform = view.transform.rotated(by: gesture.rotation)
            gesture.rotation = 0.0
        }
    }
    
    // MARK: - 흑백,컬러 전환기능
    @objc func toggleImageColor(_ sender: UISwitch) {
         if sender.isOn {
             imageView.image = viewModel.originalImage
         } else {
             imageView.image = viewModel.applyFilter(GrayscaleFilter())
         }
     }

}
