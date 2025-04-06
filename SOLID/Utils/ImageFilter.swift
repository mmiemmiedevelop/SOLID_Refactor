//
//  ImageFilter.swift
//  SOLID
//
//  Created by Mac on 4/6/25.
//
import UIKit

protocol ImageFilter {
    func apply(to image: UIImage) -> UIImage?
}

struct GrayscaleFilter: ImageFilter {
    func apply(to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        let filter = CIFilter(name: "CIPhotoEffectMono")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        guard let output = filter?.outputImage,
              let cgImage = CIContext().createCGImage(output, from: output.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
