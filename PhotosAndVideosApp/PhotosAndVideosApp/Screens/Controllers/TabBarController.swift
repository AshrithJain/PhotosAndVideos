//
//  TabBarController.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation
import UIKit


protocol HeaderAnimationHelper {
    func animateSearchHeader()
    func searchHeaderIsOpen()->Bool
}

protocol SearchHelper {
    func searchTapped(search:String)
}

class TabBarController: UIViewController {


    @IBOutlet weak var pageContainer: UICollectionView?
    @IBOutlet weak var sectionTabbarView:  TabBarHeader?
    @IBOutlet weak var searchHeader: UIView!
    @IBOutlet weak var searchHeaderHeight
    : NSLayoutConstraint!
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var headerCloseSearchBtn: UIImageView!
    @IBOutlet weak var headerBagImage: UIImageView!
    var viewControllerArray:[UIViewController]?
    var viewModel :TabBarViewModel!
    var photoTabDelegate:SearchHelper?
    var videoTabDelegate:SearchHelper?
    var favoritesTabDelegate:SearchHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.initialIndex = 0
        viewModel.selectedIndex = -1
        self.searchField.delegate = self
        self.sectionTabbarView?.delegate = self
        self.sectionTabbarView?.dataSource = self
        
        self.sectionTabbarView?.reloadData()
        self.sectionTabbarView?.selectSection(atIndex: viewModel.initialIndex ?? 0)

        self.setUpSearchField()
        
        
        DataManager.loadCuratedPhotos(page: 1, completion: {
            data in
            
            switch data {
                
            case .success(let response):
                
                if(response.photos?.count ?? 0 > 0){
                    if let url  = NSURL(string: response.photos?[0].src?.large ?? "") {
                        let data = try? Data(contentsOf: url as URL)
                        if let imageData = data {
                            if let background = UIImage(data: imageData){
                                DispatchQueue.main.async {
                                    self.headerBagImage.image = background
                                }
                                

                            }
                            
                            
                         }
                        }
                }
                

                
            case .failure(let error):
                print(error)
            }
        })
        //pageContainer.scr
        
    }
    
    
    
    func setUpSearchField(){
            
        
           let imageView = UIImageView(image: UIImage(named: "Shape"))
            imageView.contentMode = .right
        
            if let size = imageView.image?.size {
                imageView.frame = CGRect(x: 10.0, y: 0.0, width: size.width, height: size.height)
            }
            
            self.searchField.leftView = imageView
            self.searchField.leftView?.contentMode = .right
            
            searchField.leftViewMode = .always
    }
    
    @objc func headerCloseBtnTapped(){
        self.animateSearchHeader()
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.headerCloseBtnTapped))
        headerCloseSearchBtn.addGestureRecognizer(tap)
        headerCloseSearchBtn.isUserInteractionEnabled = true
        self.pageContainer?.collectionViewLayout.invalidateLayout()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setCollectionViewFlowLayout()
        self.viewModel.viewAppeared = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel.viewAppeared = false
    }
    
    
    func setCollectionViewFlowLayout() {
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        self.pageContainer?.collectionViewLayout = flowLayout
    }
    
       func sectionSelectedAtIndex(index: Int) {
        self.sectionTabbarView?.selectSection(atIndex: index)
    }
    
}


extension TabBarController:TabBarHeaderDelegate,TabBarHeaderDatasource{

    
    func numberOfSectoins(in tabBar: TabBarHeader) -> Int {
        return viewModel.tabbarItemsArray?.count ?? 0
    }
    
    func tabBar(_ tabBar: TabBarHeader, titleAt index: Int) -> String {
        return (self.viewModel.tabbarItemsArray?[index]) ?? ""
    }
    
    func tabBar(_ tabBar: TabBarHeader, didSelectSectionAt index: Int) {
        if(index != viewModel.selectedIndex){
            viewModel.selectedIndex = index
//            guard let tabBarChildVc = viewModel.viewControllerArray?[index] as? UIViewController else{
//                return
//            }
            
            self.toogleTabBar()
        }
        
                self.pageContainer?.scrollToItem(at: IndexPath(row: index, section: 0), at: [], animated: false)
    }
    
    
    func toogleTabBar(){
        
        var tabbarFrame: CGRect  = self.tabBarController?.tabBar.frame ?? CGRect.zero
        var collectionFrame: CGRect  = self.pageContainer?.frame ?? CGRect.zero
        var viewFrame: CGRect  = self.view.frame
        var isUpdate: Bool  = false
        
        if (tabbarFrame.origin.y == UIScreen.main.bounds.size.height) {
            tabbarFrame.origin.y = tabbarFrame.origin.y - tabbarFrame.size.height
            collectionFrame.size.height = collectionFrame.size.height - tabbarFrame.size.height
            viewFrame.size.height = viewFrame.size.height - tabbarFrame.size.height
            isUpdate = true
        }
        
        if (isUpdate) {
            UIView.animate(withDuration: 0.0, animations: {
                 self.view.frame = viewFrame
                self.pageContainer?.frame = collectionFrame
                self.tabBarController?.tabBar.frame = tabbarFrame
            }) { (finished) in
                self.pageContainer?.collectionViewLayout.invalidateLayout()
            }
        }
        
    }
}


extension TabBarController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewControllerArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        guard  let vc: UIViewController = self.viewControllerArray?[indexPath.row] else{
            return UICollectionViewCell()
        }
        if(!viewModel.isAnimating){
            self.displayContentController(viewController: vc, inView:cell)
        }
        
            return cell
    }
    
    func displayContentController(viewController: UIViewController, inView cell:UICollectionViewCell) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.beginAppearanceTransition(true, animated: true)
        cell.addSubview(viewController.view)
        viewController.endAppearanceTransition()
        self.addChild(viewController)
        viewController.didMove(toParent: self)
            viewController.view.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
             viewController.view.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
             viewController.view.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
             viewController.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.pageContainer?.bounds.size ?? CGSize.zero
    }
    
    
    

}


extension TabBarController: UIScrollViewDelegate{

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let cnt = Int(scrollView.contentOffset.x / self.view.frame.size.width)
             sectionSelectedAtIndex(index: cnt)
    }
    
}


extension TabBarController:HeaderAnimationHelper{
    func searchHeaderIsOpen() -> Bool {
        return viewModel.headerIsOpen
    }
    
    func animateSearchHeader(){
        viewModel.isAnimating = true
        if(viewModel.headerIsOpen){
            UIView.animate(withDuration: 0.7, animations: {
                self.searchHeaderHeight.constant = 80
                self.searchHeader.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
                self.headerCloseSearchBtn.isHidden = false
                self.headerBagImage.isHidden = true
                self.searchField.isHidden = true
                self.view.layoutIfNeeded()

                
                self.viewModel.headerIsOpen = false
                self.viewModel.isAnimating = false
                self.pageContainer?.reloadData()
            })
        }else{
            UIView.animate(withDuration: 0.7, animations: {
                self.searchHeaderHeight.constant = 360
                self.searchHeader.backgroundColor = UIColor.clear
                self.headerCloseSearchBtn.isHidden = true
                self.headerBagImage.isHidden = false
                self.searchField.isHidden = false
                self.view.layoutIfNeeded()

                self.viewModel.isAnimating = false
                self.viewModel.headerIsOpen = true
                self.pageContainer?.reloadData()
            })
        }
    }
}


extension TabBarController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let string1 = string

       
        if(string1 == "\n"){
            viewModel.searchValue = searchField.text
            
            photoTabDelegate?.searchTapped(search: viewModel.searchValue ?? "")
            videoTabDelegate?.searchTapped(search: viewModel.searchValue ?? "")
            favoritesTabDelegate?.searchTapped(search: viewModel.searchValue ?? "")
            return true
        }

        return true
    }
}
