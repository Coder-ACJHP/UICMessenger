//
//  ChatMessageCell.swift
//  UICMessageApp
//
//  Created by Onur Işık on 17.04.2019.
//  Copyright © 2019 Coder ACJHP. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    
    private static let edgeInset = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
    static let greenBuble = UIImage(named: "greenBubble")?.resizableImage(withCapInsets: edgeInset, resizingMode: .stretch)
    static let grayBuble = UIImage(named: "grayBubble")?.resizableImage(withCapInsets: edgeInset, resizingMode: .stretch)
    
    private let bubbleImageView: UIImageView = {
        let bgImageView = UIImageView()
        return bgImageView
    }()
    
    private let stackView = UIStackView()
    private let messageLabel = UILabel()
    private let bubleView = UIView()
    private let playerView = UIView()
    private let messageImgView = UICScaledImageView()
    public var chatMessage: Message! {
        didSet {
            
            if chatMessage.audioFilePath != nil {
                
                playerView.isHidden = false
                playerViewWidthConstraint.isActive = true
                playerViewHeightConstraint.isActive = true
                
            } else {
                messageLabel.text = chatMessage.text
                messageImgView.image = chatMessage.image
            }
            
            if chatMessage.isIncoming {
                bubbleImageView.image = ChatMessageCell.grayBuble
                trailingConstraint.isActive = false
                leadingConstraint.isActive = true
            } else {
                bubbleImageView.image = ChatMessageCell.greenBuble
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    private var imgWidthConstraint: NSLayoutConstraint!
    private var imgHeightConstraint: NSLayoutConstraint!
    private var playerViewWidthConstraint: NSLayoutConstraint!
    private var playerViewHeightConstraint: NSLayoutConstraint!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundColor = highlighted ? UIColor(red:0.00, green:0.64, blue:1.00, alpha:0.3) : .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected ? UIColor(red:0.00, green:0.64, blue:1.00, alpha:0.5) : .clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        bubleView.backgroundColor = .clear
        bubleView.layer.cornerRadius = 10
        bubleView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubleView)
        
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        messageImgView.contentMode = .scaleToFill
        messageImgView.clipsToBounds = true
        messageImgView.layer.cornerRadius = 10
        messageImgView.layer.masksToBounds = true
        stackView.addArrangedSubview(messageImgView)
        
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .black
        stackView.addArrangedSubview(messageLabel)
        
        
        playerView.backgroundColor = .red
        playerView.isHidden = true
        stackView.addArrangedSubview(playerView)
        
        bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
        bubleView.addSubview(bubbleImageView)
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubleView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -10),
            bubleView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),
            bubleView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            bubleView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
            
            bubbleImageView.topAnchor.constraint(equalTo: bubleView.topAnchor),
            bubbleImageView.leadingAnchor.constraint(equalTo: bubleView.leadingAnchor, constant: -12),
            bubbleImageView.bottomAnchor.constraint(equalTo: bubleView.bottomAnchor),
            bubbleImageView.trailingAnchor.constraint(equalTo: bubleView.trailingAnchor, constant: 8)
            ])
        
        leadingConstraint = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = false
        trailingConstraint = stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = false
        
        playerViewWidthConstraint = playerView.widthAnchor.constraint(equalToConstant: 150)
        playerViewWidthConstraint.isActive = false
        playerViewHeightConstraint = playerView.heightAnchor.constraint(equalToConstant: 40)
        playerViewHeightConstraint.isActive = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

