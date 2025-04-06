//
//  ImageFilterManager.swift
//  SOLID
//
//  Created by Mac on 4/6/25.
//
import UIKit

class ImageFilterManager {
    private var filter: ImageFilter?

    func setFilter(_ filter: ImageFilter) {
        self.filter = filter
    }

    func applyFilter(to image: UIImage?) -> UIImage? {
        guard let image = image else { return nil }
        return filter?.apply(to: image)
    }
}

