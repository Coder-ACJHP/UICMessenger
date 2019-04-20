//
//  UICScaledImageView.swift
//  UICMessageApp
//
//  Created by Onur Işık on 17.04.2019.
//  Copyright © 2019 Coder ACJHP. All rights reserved.
//

import UIKit

class UICScaledImageView: UIImageView {
    
    private var layoutedWidth: CGFloat = 0
    
    override var intrinsicContentSize: CGSize {
        layoutedWidth = bounds.width
        if image != nil {
            contentMode = .scaleAspectFill
            return CGSize(width: 250, height: 250)
        } else { return CGSize(width: 0, height: 0)}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if layoutedWidth != bounds.width {
            invalidateIntrinsicContentSize()
        }
    }
}
