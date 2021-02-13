//
//  StoryBoard+Extension.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation
import UIKit


enum StoryboardIdentifiers : String {
    case workerHome = "workerHomeViewController"
   
}

extension UIStoryboard{
    enum StoryboardIdentifiers : String {
        case main = "Main"

    }
    class func getMainStoryBoard()->UIStoryboard{
       return UIStoryboard(name: StoryboardIdentifiers.main.rawValue, bundle: nil)
    }
    
    func instantiateViewController<T>(withId: String? = nil, forClass: T.Type) -> T {
        let identifier = withId ?? String(describing: T.self)

        return self.instantiateViewController(withIdentifier: identifier) as! T
    }
}
