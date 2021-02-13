//
//  ServiceManager.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


class ServiceManager {
    
    public static let shared: ServiceManager = ServiceManager()
    
    public var baseURL: String = "https://api.pexels.com"
}

extension ServiceManager {
    
    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {

   
    let session =  URLSession.shared.dataTask(with: request.urlRequest(), completionHandler: { data, response, error in
        guard let data = data,let responseModel = try? JSONDecoder().decode(T.self, from: data) else {
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
               print("error")

                completion(Result.failure(error))
                return
                
            }

      
            completion(Result.success(responseModel))
     

            
            })
        session.resume()

    }
}
