//
//  String+Extension.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
