//
//  TableListViewModel.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation

enum ListType {
    case photos
    case videos
    case favourites
}

class TableListViewModel:BaseViewModel{
    var type :ListType
    var responsObj :PhotosResponseModel?
    var photos:[PhotoObject] = []
    var videos:[VideoObject] = []
    init(coordinator: Coordinator?,type:ListType) {
        self.type = type
        super.init(coordinator: coordinator)
        self.coordinator = coordinator
        
    }
    
    

    
}
