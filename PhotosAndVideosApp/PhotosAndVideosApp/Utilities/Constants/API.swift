//
//  API.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


extension Constant {
    
    static let APIKey: String = "563492ad6f9170000100000155adc5e005d34f06906b3f2a081d7905"
    
    enum API{
        case photos(search:String,pagenNum:Int)
        case curated(page:Int)
        case video(search:String,pagenNum:Int)
        
        func getRawValue()->String{
            switch self {
            case .photos(let search , let pageNo):
                
                var rawValue =  BaseAPI.photos.rawValue
                
                
                if(search.count > 0){
                    rawValue = rawValue + "?query=\(search)&per_page=20&page=\(pageNo)"
                }
                
                
                return rawValue
                
            case .curated(let page):
                var rawValue =  BaseAPI.curated.rawValue
                
                
                if(page > 0){
                    rawValue = rawValue + "?per_page=\(page)"
                }
                
                
                return rawValue
            case .video(let search, let pageNo):
                var rawValue =  BaseAPI.videos.rawValue
                
                
                if(search.count > 0){
                    rawValue = rawValue + "?query=\(search)&per_page=20&page=\(pageNo)"
                }
                
                
                return rawValue
            }
        }
    }
    
    enum BaseAPI:String{
        case photos = "/v1/search"
        case videos = "/videos/search"
        case curated = "/v1/curated"
    }
    
}
