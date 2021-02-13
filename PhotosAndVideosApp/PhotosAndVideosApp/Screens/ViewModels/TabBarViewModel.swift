//
//  TabBarViewModel.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


class TabBarViewModel:BaseViewModel{
    var headerIsOpen = true
    var  isAnimating = false
    var selectedIndex: Int?
     var initialIndex: Int?
    var searchValue:String?
    var tabbarItemsArray: [String]?
    var viewAppeared: Bool?
}
