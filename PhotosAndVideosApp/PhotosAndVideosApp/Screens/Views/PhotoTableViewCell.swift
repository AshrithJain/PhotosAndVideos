//
//  PhotoTableViewCell.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation
import UIKit

class PhotoTableViewCell:UITableViewCell{
    
    
   
    @IBOutlet weak var videoSymbol: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var bagroundImageView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var isFavoriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    func setUpPhotos(object:PhotoObject,image:UIImage){
        self.name.text = object.photographer ?? ""
        self.videoSymbol.isHidden = true
        self.imgView.image = image

    }
    
    func setUpVideo(object:VideoObject,image:UIImage){
        self.name.text = object.user?.name ?? ""
        self.videoSymbol.isHidden = false
        self.imgView.image = image
    }
    

}


