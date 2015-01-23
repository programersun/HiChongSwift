//
//  ICYImageScrollView.swift
//  CYImageBrowser
//
//  Created by eagle on 15/1/22.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import UIKit

class ICYImageScrollView: UIScrollView {
    
    weak var zoomView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let zoomView = zoomView {
            let boundsSize = bounds.size
            
            var frameToCenter = zoomView.frame
            
            if frameToCenter.size.width < boundsSize.width {
                frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2.0
            } else {
                frameToCenter.origin.x = 0.0
            }
            
            if frameToCenter.size.height < boundsSize.height {
                frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2.0
            } else {
                frameToCenter.origin.y = 0.0
            }
            
            zoomView.frame = frameToCenter
        }
    }
}
