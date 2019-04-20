//
//  ChatCell.swift
//  UICMessageApp
//
//  Created by Onur Işık on 17.04.2019.
//  Copyright © 2019 Coder ACJHP. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    var timeLabel = UILabel()
    var contact: Contact! {
        didSet {
            textLabel?.text = contact.name
            detailTextLabel?.text = contact.messages.last?.text
            imageView?.image = contact.image
            timeLabel.text = customizeDate(fromDate: contact.messages.last!.date)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        detailTextLabel?.textColor = UIColor.init(white: 0.55, alpha: 1.0)
        
        timeLabel.frame = accessoryView?.frame ?? CGRect(x: 0, y: 0, width: 100, height: 100)
        timeLabel.textAlignment = .right
        timeLabel.font = .boldSystemFont(ofSize: 14)
        accessoryView = timeLabel
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRect(x: 16, y: 0, width: 50, height: 50)
        imageView?.center.y = frame.height / 2
        imageView?.layer.cornerRadius = (imageView?.bounds.height)! / 2
        imageView?.clipsToBounds = true
        
        let imageViewWidth: CGFloat = 75
        let calculatedWidth = frame.width - imageViewWidth - timeLabel.frame.width
        let calculatedHeight = frame.height / 2 - 7
        
        textLabel?.frame = CGRect(x: imageViewWidth, y: 7, width: calculatedWidth, height: calculatedHeight)
        detailTextLabel?.frame = CGRect(x: imageViewWidth, y: calculatedHeight, width: calculatedWidth, height: calculatedHeight)
        separatorInset = UIEdgeInsets(top: separatorInset.top, left: imageViewWidth, bottom: separatorInset.bottom, right: separatorInset.right)
    }
    
    private func customizeDate(fromDate: Date) -> String {
        
        let date = fromDate
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            return "\(hour):\(minute)"
        } else {
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            return "\(day)/\(month)/\(year)"
        }
    }
}


