//
//  ViewModel.swift
//  SOLID
//
//  Created by Mac on 3/31/25.
//

import Foundation

protocol ViewModelProtocol {
    var pitures: [Picture] { get }
    var filteredPictures: [Picture] { get }
    var onDataUpdated: (() -> Void)? { get set }
    var onLoading: ((Bool) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    var searchText: String { get set }
    
    func fetchPictureList()
    func filterPictures()
}

class ViewModel: ViewModelProtocol {
    
    var pitures: [Picture] = [] {
        didSet {
            onDataUpdated?()
        }
    }
    
    var filteredPictures: [Picture] = [] {
        didSet {
            onDataUpdated?()
        }
    }
    
    var onDataUpdated: (() -> Void)?
    var onLoading: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var searchText: String = ""
    
    func fetchPictureList() {
        onLoading?(true)
        API.shard.getPictureList { [weak self] result in
            self?.onLoading?(false)
            switch result {
            case .success(let pictures):
                self?.pitures = pictures
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
    func filterPictures() {
          let keywords = searchText.lowercased().split(separator: " ").map { String($0) }
          if keywords.isEmpty {
              filteredPictures = pitures
          } else {
              filteredPictures = pitures.filter { picture in
                  let textToSearch = [
                      picture.id.lowercased(),
                      picture.author.lowercased(),
                      "\(picture.width)",
                      "\(picture.height)"
                  ].joined(separator: " ")

                  return keywords.allSatisfy { textToSearch.contains($0) }
              }
          }
      }
}
