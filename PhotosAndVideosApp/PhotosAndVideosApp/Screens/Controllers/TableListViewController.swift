//
//  TableListViewController.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation
import UIKit


class TableListViewController:UIViewController{
    var viewModel:TableListViewModel!
    var searchHeaderDelegate:HeaderAnimationHelper?
    @IBOutlet weak var tableView: UITableView!
    var photoImages:[UIImage] = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        if let search = UserDefaults.standard.object(forKey: Constant.search) as? String{
           searchTapped(search: search)
        }else{
            updateUserDefaults(val: "animal")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    func videosAPICall(search:String){
        DataManager.loadVideoObjects(search: search) {    data in
            
            switch data{
                
            case .success(let obj):
                print(obj)
                self.viewModel.responsObj = obj
                self.viewModel.videos = obj.videos ?? []

                
                for obj in self.viewModel.videos{
                    if(obj.video_pictures?.count ?? 0 > 0){
                        
                        
                        if let url  = NSURL(string: obj.video_pictures?[0].picture ?? "") {
                            let data = try? Data(contentsOf: url as URL)
                            if let imageData = data {
                                if let background = UIImage(data: imageData){
                                    self.photoImages.append(background)
                                    
                                }
                                
                                
                            }
                        }
                    }
                    
                }
                DispatchQueue.main.async {
                    if(self.tableView != nil){
                        self.tableView.reloadData()
                    }
                    
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func photosAPICall(search:String){
        DataManager.getPhotos(search: search, completion: {
            data in
            
            switch data{
                
            case .success(let obj):
                print(obj)
                self.viewModel.responsObj = obj
                self.viewModel.photos = obj.photos ?? []
                for obj in self.viewModel.photos{
                    
                    if let url  = NSURL(string: obj.src?.large ?? "") {
                        let data = try? Data(contentsOf: url as URL)
                        if let imageData = data {
                            if let background = UIImage(data: imageData){
                                self.photoImages.append(background)
                                
                            }
                            
                            
                        }
                    }
                }
                DispatchQueue.main.async {
                    if(self.tableView != nil){
                         self.tableView.reloadData()
                    }
                   
                    
                }
                
            case .failure(let error):
                print(error)
            }
            
        })
    }
    
    
    
    
}

extension TableListViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(viewModel.type == .photos){
            return viewModel.photos.count
        }else if(viewModel.type == .videos){
            return viewModel.videos.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as? PhotoTableViewCell{
            
            if(indexPath.row == 0){
                if(checkIf1stCellisVisible() && searchHeaderDelegate?.searchHeaderIsOpen() == false){
                    searchHeaderDelegate?.animateSearchHeader()
                }
            }else if(indexPath.row > 1){
                if(!checkIf1stCellisVisible() && searchHeaderDelegate?.searchHeaderIsOpen() == true){
                    searchHeaderDelegate?.animateSearchHeader()
                }
            }
            
            if(indexPath.row < photoImages.count){
                if(viewModel.type == .photos){
                   cell.setUpPhotos(object: self.viewModel.photos[indexPath.row],image: photoImages[indexPath.row])
                }else if(viewModel.type == .videos){
                    cell.setUpVideo(object: self.viewModel.videos[indexPath.row], image: photoImages[indexPath.row])
                }
                
            }
            
            
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    
    func checkIf1stCellisVisible()->Bool{
        if let indices = tableView.indexPathsForVisibleRows {
            for index in indices {
                if index.row == 0 {
                    return true
                }
            }
        }
        return false
    }
    
}


extension TableListViewController:SearchHelper{
    func searchTapped(search: String) {
        updateUserDefaults(val: search)
        if(viewModel.type == .photos){
            self.photosAPICall(search: search)
            self.photoImages.removeAll()
        }else if(viewModel.type == .videos){
            self.videosAPICall(search: search)
            self.photoImages.removeAll()
        }
    }
    
    func updateUserDefaults(val:String){
        UserDefaults.standard.set(val, forKey: Constant.search)
    }
    
}
