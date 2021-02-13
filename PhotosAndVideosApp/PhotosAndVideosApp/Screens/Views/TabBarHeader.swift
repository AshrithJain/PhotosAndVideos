//
//  TabBarHeader.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


import UIKit

  protocol TabBarHeaderDelegate  {
    func tabBar(_ tabBar:TabBarHeader,didSelectSectionAt index:Int)
}

 protocol TabBarHeaderDatasource  {
    func numberOfSectoins(in tabBar:TabBarHeader) -> Int
    func tabBar(_ tabBar:TabBarHeader, titleAt index:Int) -> String
}

class TabBarHeader: UIView ,UIScrollViewDelegate{
    
    public var delegate : TabBarHeaderDelegate? = nil
    public var dataSource : TabBarHeaderDatasource? = nil
    public var currentFont : UIFont = UIFont.boldSystemFont(ofSize: 12)
    public var unselectedColor : UIColor = UIColor.init(red: 0.14, green: 0.03, blue: 0.21, alpha: 0.5)
    
    
    public var selectedColor : UIColor = UIColor.init(red: 0.91, green:0.07, blue: 0.27, alpha: 1)
    public var bottomViewColor : UIColor = UIColor.init(red:0.91, green: 0.07, blue: 0.27, alpha: 1)
    
    private let BOTTOM_VIEW_ANIMATION_DURATION = 0.25
    private let BOTTOM_VIEW_HEIGHT : CGFloat = 3.0
    private let BUTTON_TAG_OFFSET = 1245
    private let CONTENT_INSENT_LEFT = 10
    private let CONTENT_INSENT_ZERO = 0
    private let FONT_SIZE = 16
    private let ZERO_OFFSET : CGFloat = 0.0
    private let SECTION_TITILE_MAX_BOUNDED_SIZE = CGSize (width: 500, height: 45)
    
    private var scrollView : UIScrollView!
    private var bottomView : UIView!
    
    private var selectedButton = UIButton ()
    private var contentWidth : CGFloat = 0.0
    private var buttonsArray = [UIButton]()
    private var numberOfItems : Int = 0
    
    public func selectSection (atIndex index : Int) -> () {
        if let button = viewWithTag(index + BUTTON_TAG_OFFSET) as? UIButton {
            didTap(selectedButton: button)
        }
    }
    
    
    public override func awakeFromNib() {
        
    }
    
    public func reloadData () {
        self.scrollView?.removeFromSuperview()
        buttonsArray.removeAll()
        self.scrollView = nil
        bottomView?.removeFromSuperview()
        setUpScrollView()
        setUpSections ()
        setContentOffset(withPoint: CGPoint(x:0,y:0), withAnimation: true)
    }
    
    private func setUpScrollView () {
        scrollView = UIScrollView.init(frame: self.bounds)
         scrollView.delegate = self
        scrollView.backgroundColor = UIColor.clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.autoresizingMask = .flexibleWidth
        scrollView.contentInset = .zero
        scrollView.contentOffset = CGPoint(x:0,y:0)
        bottomView = UIView.init()
        bottomView.backgroundColor = bottomViewColor
       
        self.addSubview(scrollView)
        scrollView.addSubview(bottomView)
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    private func setUpSections () {
        numberOfItems = dataSource!.numberOfSectoins(in: self)
        
        let offSet : CGFloat = 15.0
        
        var contentWidth : CGFloat = ZERO_OFFSET
        contentWidth = contentWidth + 17
        var buttonTag = 0 + BUTTON_TAG_OFFSET
        
        for index in 0 ..< numberOfItems  {
            
            let sectionButton = UIButton.init(type: .custom)
            sectionButton.tag = buttonTag
            
            let title = dataSource!.tabBar(self, titleAt: index)
            sectionButton.setTitle(title, for: .normal)
            sectionButton.contentHorizontalAlignment = .center
            sectionButton.contentVerticalAlignment = .center
            sectionButton.setTitleColor(unselectedColor, for: .normal)
            sectionButton.setTitleColor(selectedColor, for: .selected)
            sectionButton.addTarget(self, action: #selector(didTap(selectedButton:)), for: .touchUpInside)
            sectionButton.titleLabel?.font = currentFont
            
            var textSize = (title as NSString).boundingRect(with: SECTION_TITILE_MAX_BOUNDED_SIZE, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: currentFont], context: nil)
            textSize.size.width = textSize.size.width + offSet;
            sectionButton.frame = CGRect (x: contentWidth, y: ZERO_OFFSET, width: textSize.size.width, height: scrollView.bounds.size.height)
            
            contentWidth = contentWidth + textSize.size.width
            
            scrollView.addSubview(sectionButton)
            buttonsArray.append(sectionButton)
            buttonTag = buttonTag + 1
        }
        
        scrollView.contentSize = CGSize (width: contentWidth, height: scrollView.bounds.size.height)
        selectedButton = buttonsArray.first!
        selectedButton.isSelected = true
        setUpInitialBottomView ()
    }
    
    @objc private func didTap(selectedButton button:UIButton ) {
        selectedButton.isSelected = false
        selectedButton = button
        selectedButton.isSelected = true
        let index = selectedButton.tag - BUTTON_TAG_OFFSET
        
        delegate!.tabBar(self, didSelectSectionAt: index)
        
        if index > 0 {
            
            let leftButton = buttonsArray[index - 1]
            let visibleRect = CGRect (x: scrollView.contentOffset.x, y: scrollView.contentOffset.y, width: scrollView.bounds.size.width, height: scrollView.bounds.size.height)
            if visibleRect.intersects(leftButton.frame) == false || leftButton.frame.origin.x < visibleRect.origin.x {
                
                var newContentOffset = scrollView.contentOffset
                newContentOffset.x = leftButton.frame.origin.x
                setContentOffset(withPoint: newContentOffset, withAnimation: true)
                
            } else if index < buttonsArray.count - 1 {
                
                let rightButton = buttonsArray [index + 1]
                
                if visibleRect.intersects(rightButton.frame) == false || (rightButton.frame.origin.x + rightButton.bounds.size.width) > visibleRect.origin.x + visibleRect.size.width {
                    
                    var newContentOffset = scrollView.contentOffset
                    newContentOffset.x = rightButton.frame.origin.x + rightButton.bounds.size.width - scrollView.bounds.size.width
                    setContentOffset(withPoint: newContentOffset, withAnimation: true)
                }
            }
        }
        else {
            setContentOffset(withPoint: CGPoint(x:0,y:0), withAnimation: true)
        }
        
        UIView.animate(withDuration: BOTTOM_VIEW_ANIMATION_DURATION) {
            var newFrame = self.bottomView.frame
            newFrame.origin.x = button.frame.origin.x
            newFrame.size.width = button.frame.size.width
            self.bottomView.frame = newFrame
        }
    }
    
    private func setUpInitialBottomView () {
        var frame = selectedButton.frame
        frame.origin.y = frame.size.height - BOTTOM_VIEW_HEIGHT
        bottomView.frame = frame
    }
    
    /**
     This method updates button frame if content width is less than the device width.
     */
    private func updateButtonFrame () {
        
        let minimumWidth = UIScreen.main.bounds.width / CGFloat (numberOfItems)
        var newOffset = ZERO_OFFSET
        
        for button in buttonsArray  {
            var frame = button.frame
            frame.origin.x = frame.origin.x + newOffset
            
            if button.bounds.size.width < minimumWidth {
                newOffset = round(minimumWidth - button.bounds.size.width)
                frame.size.width = newOffset
            }
            button.frame = frame
            contentWidth = button.frame.origin.x + button.bounds.size.width
        }
    }
    
    private func setContentOffset (withPoint point:CGPoint, withAnimation animation:Bool) {
        let animationDuration = animation ? 0.2 : 0.0
        UIView.animate(withDuration: animationDuration) {
            self.scrollView.contentOffset = point
        }
    }
}
