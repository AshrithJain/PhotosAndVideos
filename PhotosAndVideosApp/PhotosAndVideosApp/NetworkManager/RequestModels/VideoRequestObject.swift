//
//  VideoRequestObject.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


class VideoRequestObject: RequestModel {
    
    var search:String
   
    init(search:String) {
        self.search = search
        
    }
    override var headers: [String : String]{
        return ["Authorization":"\(Constant.APIKey)"]
    }
    override var path: String{
        return Constant.API.video(search: search).getRawValue()
    }
    
}
