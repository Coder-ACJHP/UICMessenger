//
//  FloatStartChatButton.swift
//  UICMessageApp
//
//  Created by Onur Işık on 17.04.2019.
//  Copyright © 2019 Coder ACJHP. All rights reserved.
//

import UIKit

protocol FloatingStartChatButtonDelegate: AnyObject {
    func floatingStartChatButtonPressed(_ FloatingStartChatButton: FloatingStartChatButton)
}

class FloatingStartChatButton: UIView {
    
    let startChatButtonSize: CGFloat = 60
    private static let mainColor = UIColor(red:0.35, green:0.73, blue:0.22, alpha:1.0)
    private static let tempColor = UIColor(red:0.35, green:0.73, blue:0.22, alpha:0.7)
    
    public weak var delegate: FloatingStartChatButtonDelegate?
    
    private let startChatButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(handlePress), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let imageView: UIImageView = {
        let icon = UIImage(named: "startChat")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: icon)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commontInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commontInit() {

        adjustCustomizing()
        
        addSubview(imageView)
        
        addSubview(startChatButton)
        
        NSLayoutConstraint.activate([
            
            imageView.widthAnchor.constraint(equalToConstant: startChatButtonSize / 2),
            imageView.heightAnchor.constraint(equalToConstant: startChatButtonSize / 2),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            startChatButton.widthAnchor.constraint(equalToConstant: startChatButtonSize),
            startChatButton.heightAnchor.constraint(equalToConstant: startChatButtonSize),
            startChatButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startChatButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func adjustCustomizing() {
        layer.cornerRadius = startChatButtonSize / 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.3
        let path = UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: startChatButtonSize, height: startChatButtonSize), cornerRadius: startChatButtonSize / 2).cgPath
        layer.shadowPath = path
        layer.shouldRasterize = true
        backgroundColor = FloatingStartChatButton.mainColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc fileprivate func handlePress() {
        self.imageView.alpha = 0
        self.backgroundColor = FloatingStartChatButton.tempColor
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .showHideTransitionViews, animations: {
            self.imageView.alpha = 1
            self.backgroundColor = FloatingStartChatButton.mainColor
        })
        
        self.delegate?.floatingStartChatButtonPressed(self)
    }

}
