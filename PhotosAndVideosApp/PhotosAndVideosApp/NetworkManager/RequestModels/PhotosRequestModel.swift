//
//  PhotosRequestModel.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


class PhotosRequestModel: RequestModel {
    
    var search:String
   
    init(search:String) {
        self.search = search
        
    }
    override var headers: [String : String]{
        return ["Authorization":"\(Constant.APIKey)"]
    }
    override var path: String{
        return Constant.API.photos(search: search).getRawValue()
    }
    
}

class CuratedRequestModel:RequestModel{
     var page:Int
    
     init(page:Int) {
         self.page = page
         
     }
     override var headers: [String : String]{
         return ["Authorization":"\(Constant.APIKey)"]
     }
     override var path: String{
        return Constant.API.curated(page: page).getRawValue()
     }
}


