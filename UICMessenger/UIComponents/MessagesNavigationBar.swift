//
//  CommonNavigationBar.swift
//  UICMessenger
//
//  Created by Onur Işık on 17.04.2019.
//  Copyright © 2019 Coder ACJHP. All rights reserved.
//

import UIKit

protocol MessagesNavigationBarDelegate: AnyObject {
    func commonNavigationBar(_ navigationBar: MessagesNavigationBar, pressedButtonTag: Int)
}

class MessagesNavigationBar: UIView {
    
    public var icon: UIImage! {
        didSet {
            headerIconImageView.image = icon
        }
    }
    
    public var title: String! {
        didSet {
            headerLabel.text = title
        }
    }
    
    public var detail: String! {
        didSet {
            titleLabel.text = detail
        }
    }
    
    weak var delegate: MessagesNavigationBarDelegate?
    
    private var headerIconImageView: UIImageView!
    private var headerLabel: UILabel!
    private var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red:0/255, green:99/255, blue:64/255, alpha:1.0)
        translatesAutoresizingMaskIntoConstraints = false
        
        configureElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureElements() {
        
        let backButton = UIButton(type: .system)
        let backIcon = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = .white
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(handlePress(_:)), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backButton)
        
        headerIconImageView = UIImageView(frame: .zero)
        headerIconImageView.contentMode = .scaleAspectFit
        headerIconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerIconImageView)
        
        headerLabel = UILabel(frame: .zero)
        headerLabel.text = "UICMessenger"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 19)
        headerLabel.textColor = .white
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerLabel)
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.text = "UICMessenger"
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        let menuButton = UIButton(type: .system)
        let menuIcon = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
        menuButton.setImage(menuIcon, for: .normal)
        menuButton.tintColor = .white
        menuButton.tag = 1
        menuButton.imageView?.contentMode = .scaleAspectFit
        menuButton.addTarget(self, action: #selector(handlePress(_:)), for: .touchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(menuButton)
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 25),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            headerIconImageView.widthAnchor.constraint(equalToConstant: 45),
            headerIconImageView.heightAnchor.constraint(equalToConstant: 45),
            headerIconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            headerIconImageView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 8),
            
            menuButton.widthAnchor.constraint(equalToConstant: 35),
            menuButton.heightAnchor.constraint(equalToConstant: 35),
            menuButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: headerIconImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: 16),
            
            headerLabel.heightAnchor.constraint(equalToConstant: 20),
            headerLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: headerIconImageView.trailingAnchor, constant: 8),
            headerLabel.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: 16),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerIconImageView.layer.cornerRadius = headerIconImageView.bounds.height / 2
        headerIconImageView.clipsToBounds = true
    }
    
    @objc fileprivate func handlePress(_ sender: UIButton) {
        delegate?.commonNavigationBar(self, pressedButtonTag: sender.tag)
    }
}
