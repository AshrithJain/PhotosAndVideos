//
//  VideoObject.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


struct VideoObject :Codable{
    var id:Int?
    var width:Int?
    var height:Int?
    var url:String?
    var image:String?
    var duration:Int?
    var user:User?
    var video_files:[VideoFile]?
    var video_pictures:[VideoPictures]?
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        id  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.id))
        width  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.width))
        height  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.height))
        url  = (try? keyedContainer.decode(String.self, forKey: CodingKeys.url))
        image = (try? keyedContainer.decode(String.self, forKey: CodingKeys.image))
        duration = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.duration))
        user = (try? keyedContainer.decode(User.self, forKey: CodingKeys.user))
        video_files = (try? keyedContainer.decode([VideoFile].self, forKey: CodingKeys.video_files))
        video_pictures = (try? keyedContainer.decode([VideoPictures].self, forKey: CodingKeys.video_pictures))
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case url
        case image
        case duration
        case user
        case video_files
        case video_pictures
    }
}


struct User:Codable {
    var id:Int?
    var name:String?
    var url:String?
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        id  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.id))
        name = (try? keyedContainer.decode(String.self, forKey: CodingKeys.name))
        url = (try? keyedContainer.decode(String.self, forKey: CodingKeys.url))
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
    
    }
}

struct VideoFile:Codable {
    var id:Int?
    var width:Int?
    var height:Int?
    var quality:String?
    var file_type:String?
    var link:String?
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        id  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.id))
        width  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.width))
        height  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.height))
        quality = (try? keyedContainer.decode(String.self, forKey: CodingKeys.quality))
        file_type = (try? keyedContainer.decode(String.self, forKey: CodingKeys.file_type))
        link = (try? keyedContainer.decode(String.self, forKey: CodingKeys.link))
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case quality
        case file_type
        case link
    }
    
}


struct VideoPictures:Codable {
    var id:Int?
    var picture:String?
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        id  = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.id))
        picture = (try? keyedContainer.decode(String.self, forKey: CodingKeys.picture))
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case picture
    }
}
