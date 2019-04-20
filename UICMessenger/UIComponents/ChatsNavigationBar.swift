//
//  ChatsNavigationBar.swift
//  UICMessenger
//
//  Created by Onur Işık on 17.04.2019.
//  Copyright © 2019 Coder ACJHP. All rights reserved.
//

import UIKit

protocol ChatsNavigationBarDelegate: AnyObject {
    func chatsNavigationBar(_ navigationBar: ChatsNavigationBar, pressedButtonTag: Int)
}

class ChatsNavigationBar: UIView {
    
    public enum Status: String {
        case Collapsed = "collapsed"
        case Expanded = "expanded"
    }
    
    public var status = Status.Expanded {
        didSet {
            if status == .Collapsed {
                upperStackView.isHidden = true
                bottomStackViewTopConstraintToUpperStackView?.isActive = false
                bottomStackViewTopConstraintToContainerView?.isActive = true
            } else {
                upperStackView.isHidden = false
                bottomStackViewTopConstraintToContainerView?.isActive = false
                bottomStackViewTopConstraintToUpperStackView?.isActive = true
            }
        }
    }
    
    private var upperStackView: UIStackView!
    private var bottomStackView: UIStackView!
    private var bottomStackViewTopConstraintToUpperStackView: NSLayoutConstraint?
    private var bottomStackViewTopConstraintToContainerView: NSLayoutConstraint?
    private var headerButtonsList = [UIButton]()
    
    weak var delegate: ChatsNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red:0/255, green:99/255, blue:64/255, alpha:1.0)
        translatesAutoresizingMaskIntoConstraints = false
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.text = "UICMessenger"
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let searchButton = UIButton(type: .system)
        let searchIcon = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        searchButton.setImage(searchIcon, for: .normal)
        searchButton.tintColor = .white
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.addTarget(self, action: #selector(handlePress(_:)), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        let menuButton = UIButton(type: .system)
        let menuIcon = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
        menuButton.setImage(menuIcon, for: .normal)
        menuButton.tintColor = .white
        menuButton.tag = 1
        menuButton.imageView?.contentMode = .scaleAspectFit
        menuButton.addTarget(self, action: #selector(handlePress(_:)), for: .touchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        upperStackView = UIStackView(arrangedSubviews: [titleLabel, searchButton, menuButton])
        upperStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(upperStackView)
        
        
        let cameraButton = UIButton(type: .system)
        let cameraIcon = UIImage(named: "camera")?.withRenderingMode(.alwaysTemplate)
        cameraButton.setImage(cameraIcon, for: .normal)
        cameraButton.tintColor = .init(white: 1, alpha: 0.6)
        cameraButton.imageView?.contentMode = .scaleAspectFit
        cameraButton.tag = 2
        cameraButton.addTarget(self, action: #selector(handlePress(_:)), for: .touchUpInside)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        
        let chatButton = UIButton(type: .system)
        chatButton.setTitle("CHATS", for: .normal)
        chatButton.tintColor = .white
        chatButton.isSelected = true
        chatButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 16)
        chatButton.tag = 3
        chatButton.addTarget(self, action: #selector(handlePress(_:)), for: .touchUpInside)
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        headerButtonsList.append(chatButton)
        
        let statusButton = UIButton(type: .system)
        statusButton.setTitle("STATUS", for: .normal)
        statusButton.titleLabel!.textColor = .white
        statusButton.tintColor = .white
        statusButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 16)
        statusButton.tag = 4
        statusButton.addTarget(self, action: #selector(handlePress(_:)), for: .touchUpInside)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        headerButtonsList.append(statusButton)
        
        let callButton = UIButton(type: .system)
        callButton.setTitle("CALLS", for: .normal)
        callButton.titleLabel!.textColor = .white
        callButton.tintColor = .white
        callButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 16)
        callButton.tag = 5
        callButton.addTarget(self, action: #selector(handlePress(_:)), for: .touchUpInside)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        headerButtonsList.append(callButton)
        
        bottomStackView = UIStackView(arrangedSubviews: [cameraButton, chatButton, statusButton, callButton])
        bottomStackView.distribution = .fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            
            upperStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            upperStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            upperStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            upperStackView.heightAnchor.constraint(equalToConstant: 35),
            
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 260),
            menuButton.widthAnchor.constraint(lessThanOrEqualToConstant: 35),
            searchButton.widthAnchor.constraint(lessThanOrEqualToConstant: 35),
            
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        bottomStackViewTopConstraintToUpperStackView = bottomStackView.topAnchor.constraint(equalTo: upperStackView.bottomAnchor, constant: 4)
        bottomStackViewTopConstraintToUpperStackView?.isActive = true
        
        bottomStackViewTopConstraintToContainerView = bottomStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4)
        bottomStackViewTopConstraintToContainerView?.isActive = false
    }
    
    
    @objc fileprivate func handlePress(_ sender: UIButton) {
        
        delegate?.chatsNavigationBar(self, pressedButtonTag: sender.tag)
        
        headerButtonsList.forEach { (button) in
            if button.tag != sender.tag {
                button.isSelected = false
            } else {
                button.isSelected = true
            }
        }
    }
}
