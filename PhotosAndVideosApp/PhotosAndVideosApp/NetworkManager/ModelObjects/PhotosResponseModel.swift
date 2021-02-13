//
//  PhotosResponseModel.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation

struct PhotosResponseModel:Codable{
    var total_results:Int?
    var page:Int?
    var per_page:Int?
    var next_page:String?
    var photos:[PhotoObject]?
    var videos:[VideoObject]?
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        total_results  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.total_results))
        page  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.page))
        per_page  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.per_page))
        next_page  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.next_page))
        photos  = (try? keyedContainer.decode([PhotoObject].self, forKey: CodingKeys.photos))
        videos  = (try? keyedContainer.decode([VideoObject].self, forKey: CodingKeys.videos))
        
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case total_results
        case page
        case per_page
        case next_page
        case photos
        case videos
        
    }
    
}
