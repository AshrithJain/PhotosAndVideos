//
//  PhotoObject.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


struct PhotoObject:Codable{
    var id:Int?
    var width:Int?
    var height:Int?
    var url:String?
    var photographer:String?
    var photographer_url:String?
    var photographer_id:Int?
    var avg_color:String?
    var src:Source?
    var liked:Bool?
    
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        id  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.id))
       width  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.width))
        height  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.height))
        url  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.url))
        photographer  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.photographer))
        photographer_id  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.photographer_id))
        photographer_url  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.photographer_url))
         avg_color  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.avg_color))
        src = (try? keyedContainer.decode(Source.self, forKey: CodingKeys.src))
        liked = (try? keyedContainer.decode(Bool.self, forKey: CodingKeys.liked))
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case url
        case photographer
        case photographer_url
        case photographer_id
        case avg_color
        case src
        case liked
    }
}



struct Source:Codable{
    var original:String?
    var large2x:String?
    var large:String?
    var medium:String?
    var small:String?
    var portrait:String?
    var landscape:String?
    var tiny:String?
    
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        original  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.original))
       large2x  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.large2x))
        large  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.large))
        medium  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.medium))
        small  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.small))
        portrait  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.portrait))
        landscape  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.landscape))
         tiny  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.tiny))

    }
    
    private enum CodingKeys: String, CodingKey {
        case original
        case large2x
        case large
        case medium
        case small
        case portrait
        case landscape
        case tiny
    }
}

//{
//  "id": 2014422,
//  "width": 3024,
//  "height": 3024,
//  "url": "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
//  "photographer": "Joey Farina",
//  "photographer_url": "https://www.pexels.com/@joey",
//  "photographer_id": 680589,
//  "avg_color": "#978E82",
//  "src": {
//    "original": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg",
//    "large2x": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
//    "large": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
//    "medium": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350",
//    "small": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130",
//    "portrait": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
//    "landscape": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
//    "tiny": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
//  }
//}
