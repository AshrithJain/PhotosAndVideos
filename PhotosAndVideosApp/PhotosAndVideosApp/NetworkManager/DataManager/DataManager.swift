//
//  DataManager.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


class DataManager {
    class func getPhotos(search: String, completion: @escaping(Swift.Result<PhotosResponseModel, ErrorModel>)->Void) {
        ServiceManager.shared.sendRequest(request: PhotosRequestModel(search: search)) { (result) in
            completion(result)
        }
    }
    
    class func loadCuratedPhotos(page: Int, completion: @escaping(Swift.Result<PhotosResponseModel, ErrorModel>)->Void) {
        ServiceManager.shared.sendRequest(request: CuratedRequestModel(page: 1)) { (result) in
            completion(result)
        }
    }
    
    class func loadVideoObjects(search: String, completion: @escaping(Swift.Result<PhotosResponseModel, ErrorModel>)->Void) {
        ServiceManager.shared.sendRequest(request: VideoRequestObject(search: search)) { (result) in
            completion(result)
        }
    }
}
