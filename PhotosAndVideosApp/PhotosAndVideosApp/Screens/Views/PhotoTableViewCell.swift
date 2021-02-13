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
    var favouriteDelegate:FavoriteTapped?
    var isFavorite = false
    
    var photoObj:PhotoObject?
    var videoObj:VideoObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.headerTapped))
        isFavoriteImage.addGestureRecognizer(tap)
        isFavoriteImage.isUserInteractionEnabled = true
        
    }
    

    func setUpPhotos(object:PhotoObject,image:UIImage,isFavourite:Bool=false){
        self.name.text = object.photographer ?? ""
        self.videoSymbol.isHidden = true
        self.imgView.image = image
        photoObj = object
        self.isFavorite = isFavourite
        if(isFavourite){
            isFavoriteImage.image = UIImage(named: "Path Copy")
        }else{
            isFavoriteImage.image = UIImage(named: "Path")
        }
    }
    
    func setUpVideo(object:VideoObject,image:UIImage,isFavourite:Bool=false){
        self.name.text = object.user?.name ?? ""
        self.videoSymbol.isHidden = false
        self.imgView.image = image
        videoObj = object
        if(isFavourite){
            isFavoriteImage.image = UIImage(named: "Path Copy")
        }else{
            isFavoriteImage.image = UIImage(named: "Path")
        }
    }
    
    
  @objc  func headerTapped (){
    if(self.isFavorite){
        if let photo  = photoObj{
            favouriteDelegate?.removeFromFavourites(obj: photo )
        }else if let video = videoObj{
            favouriteDelegate?.removeFromFavourites(obj: video)
        }
    }else{
        if let photo  = photoObj{
            favouriteDelegate?.addToFavourites(obj: photo)
        }else if let video = videoObj{
            favouriteDelegate?.addToFavourites(obj: video)
        }
    }
    }

}


