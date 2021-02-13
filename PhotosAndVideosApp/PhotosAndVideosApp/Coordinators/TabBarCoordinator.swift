//
//  TabBarCoordinator.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    var navigationController:UINavigationController?
    
      init(navController:UINavigationController?) {
        super.init(parent: nil)
        self.navigationController = navController
        
        addEventHandlers()
    }
    func createFlow(){
        
        let controller = UIStoryboard.getMainStoryBoard().instantiateViewController(forClass: TabBarController.self)
         
        let viewModel = TabBarViewModel(coordinator: self)
         let vc1 = UIStoryboard.getMainStoryBoard().instantiateViewController(forClass: TableListViewController.self)
        vc1.viewModel = TableListViewModel(coordinator: self, type: .photos)
        vc1.searchHeaderDelegate = controller
         let vc2 = UIStoryboard.getMainStoryBoard().instantiateViewController(forClass: TableListViewController.self)
        vc2.viewModel = TableListViewModel(coordinator: self, type: .videos)
        vc2.searchHeaderDelegate = controller
         let vc3 = UIStoryboard.getMainStoryBoard().instantiateViewController(forClass: TableListViewController.self)
        vc3.viewModel = TableListViewModel(coordinator: self, type: .favourites)
        vc3.searchHeaderDelegate = controller

        controller.photoTabDelegate = vc1
        controller.videoTabDelegate = vc2
        controller.favoritesTabDelegate = vc3
        controller.viewControllerArray = [vc1,vc2,vc3]
        viewModel.tabbarItemsArray = ["Photos","Videos","Favorites"]
        controller.viewModel = viewModel
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    func addEventHandlers() {
        
    }
    
}
