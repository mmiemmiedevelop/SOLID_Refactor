//
//  Model.swift
//  SOLID
//
//  Created by Mac on 3/31/25.
//

import Foundation

struct Picture: Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let download_url: String
}
