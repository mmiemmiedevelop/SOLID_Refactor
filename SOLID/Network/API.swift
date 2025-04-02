//
//  API.swift
//  SOLID
//
//  Created by Mac on 3/31/25.
//

import Foundation
import Alamofire

class API {
    
    static let shard = API()
    
    func getPictureList(completionHandler: @escaping (Result<[Picture], Error>) -> Void) {
         let url = BASE_URL + "/v2/list"
         get(url: url, completionHandler: completionHandler)
     }
    
}
