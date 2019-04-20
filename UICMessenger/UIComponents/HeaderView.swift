//
//  HeaderView.swift
//  UICMessageApp
//
//  Created by Onur Işık on 17.04.2019.
//  Copyright © 2019 Coder ACJHP. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    let label = HeaderViewLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
