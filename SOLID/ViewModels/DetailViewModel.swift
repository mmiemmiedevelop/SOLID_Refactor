//
//  DetailViewModel.swift
//  SOLID
//
//  Created by Mac on 4/1/25.
//
import UIKit
import CoreImage

class DetailViewModel {
    
    var originalImage: UIImage! {
        didSet {
            onDataUpdated?()
        }
    }
    
    var onDataUpdated: (() -> Void)?
    var onLoading: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    private let filterManager = ImageFilterManager()
    
    func loadImage(from urlString: String) {
        onLoading?(true)
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            self.onLoading?(false)
            if let error = error {
                self.onError?(error.localizedDescription)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                self.onError?("이미지 불러오기 실패")
                return
            }
            DispatchQueue.main.async {
                self.originalImage = image
            }
        }
        task.resume()
    }
    
    func applyFilter(_ filter: ImageFilter) -> UIImage? {
          filterManager.setFilter(filter)
          return filterManager.applyFilter(to: originalImage)
      }
    
}
