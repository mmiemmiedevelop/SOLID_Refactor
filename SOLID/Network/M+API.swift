//
//  M+API.swift
//  SOLID
//
//  Created by Mac on 3/31/25.
//

import Foundation
import Alamofire

extension API {
    
    func get<T: Decodable>(url: String, completionHandler: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let decodedData):
                    completionHandler(.success(decodedData))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
    
}
