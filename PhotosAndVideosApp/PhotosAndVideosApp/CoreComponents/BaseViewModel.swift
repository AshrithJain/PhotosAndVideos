//
//  BaseViewModel.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


class BaseViewModel:NSObject{
    var coordinator:Coordinator?
    init(coordinator:Coordinator?) {
        self.coordinator = coordinator
    }
}
