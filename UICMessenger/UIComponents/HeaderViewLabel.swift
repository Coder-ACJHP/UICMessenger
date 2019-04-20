//
//  HeaderViewLabel.swift
//  UICMessageApp
//
//  Created by Onur Işık on 17.04.2019.
//  Copyright © 2019 Coder ACJHP. All rights reserved.
//

import UIKit

class HeaderViewLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red:0.49, green:0.71, blue:0.78, alpha:1.0)
        textColor = .white
        textAlignment = .center
        font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(width: originalSize.width + 14, height: originalSize.height + 8)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = (frame.height / 2) - 5
        layer.masksToBounds = true
    }
}
