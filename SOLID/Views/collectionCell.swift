//
//  collectionCell.swift
//  SOLID
//
//  Created by Mac on 4/1/25.
//

import UIKit

class collectionCell: UICollectionViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
   
    func configure(with picture: Picture, searchText: String) {
        let keywords = searchText.lowercased().split(separator: " ").map { String($0) }

        idLabel.attributedText = highlightText(fullText: "Id: " + picture.id, keywords: keywords)
        authorLabel.attributedText = highlightText(fullText: "Author: " + picture.author, keywords: keywords)
        widthLabel.attributedText = highlightText(fullText: "Width: " + "\(picture.width)", keywords: keywords)
        heightLabel.attributedText = highlightText(fullText: "Height: " + "\(picture.height)", keywords: keywords)

    }

    private func highlightText(fullText: String, keywords: [String]) -> NSAttributedString {
          let attributedString = NSMutableAttributedString(string: fullText)
          let lowercasedFullText = fullText.lowercased()
          
          for keyword in keywords {
              if let range = lowercasedFullText.range(of: keyword) {
                  let nsRange = NSRange(range, in: fullText)
                  attributedString.addAttribute(.backgroundColor, value: UIColor.green, range: nsRange)
              }
          }
          return attributedString
      }
    
}
