//
//  MockDataProvider.swift
//  UICMessageApp
//
//  Created by Onur Işık on 17.04.2019.
//  Copyright © 2019 Coder ACJHP. All rights reserved.
//
import UIKit

struct MockContactListProvider {
    
    fileprivate func dateFromString(pattern: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: pattern) ?? Date()
    }
    
    public func generateMessages() -> [Message] {
        return
            [Message(text: "This technique is very easy and requires very little customization. Enjoy.", image: #imageLiteral(resourceName: "background-3"), isIncoming: true, date: Date(), audioFilePath: nil),
             Message(text: "Little short message", image: nil, isIncoming: true, date: dateFromString(pattern: "13/03/2017"), audioFilePath: nil),
             Message(text: "In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints.", image: nil, isIncoming: false, date: dateFromString(pattern: "13/03/2017"), audioFilePath: nil),
             Message(text: "Provides auto sizing using anchor constraints. This technique is very easy and requires very little customization. Enjoy.", image: nil, isIncoming: false, date: dateFromString(pattern: "13/03/2017"), audioFilePath: nil),
             Message(text: "A very common task in iOS is to provide auto sizing cells for UITableView components. In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints. This technique is very easy and requires very little customization. Enjoy.", image: nil, isIncoming: true, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "This technique is very easy and requires very little customization. Enjoy.", image: nil, isIncoming: false, date: dateFromString(pattern: "17/04/2017"), audioFilePath: nil),
             Message(text: "Little short message", image: nil, isIncoming: true, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints.", image: nil, isIncoming: false, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "Provides auto sizing using anchor constraints. This technique is very easy and requires very little customization. Enjoy.", image: nil, isIncoming: true, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints.", image: nil, isIncoming: false, date: dateFromString(pattern: "17/03/2017"), audioFilePath: nil),
             Message(text: "This technique is very easy and requires very little customization. Enjoy.", image: nil, isIncoming: false, date: dateFromString(pattern: "17/04/2017"), audioFilePath: nil),
             Message(text: "Little short message", image: nil, isIncoming: true, date: dateFromString(pattern: "17/03/2017"), audioFilePath: nil),
             Message(text: "Waaw really cool 🎉", image: nil, isIncoming: true, date: dateFromString(pattern: "17/03/2017"), audioFilePath: nil),
             Message(text: "😄😄😄😄", image: nil,  isIncoming: true, date: dateFromString(pattern: "17/04/2017"), audioFilePath: nil),
             Message(text: "Little short message",  image: nil, isIncoming: true, date: dateFromString(pattern: "13/03/2017"), audioFilePath: nil),
             Message(text: "In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints.", image: nil,  isIncoming: false, date: dateFromString(pattern: "13/03/2017"), audioFilePath: nil),
             Message(text: "Provides auto sizing using anchor constraints. This technique is very easy and requires very little customization. Enjoy.", image: nil,  isIncoming: false, date: dateFromString(pattern: "13/03/2017"), audioFilePath: nil),
             Message(text: "A very common task in iOS is to provide auto sizing cells for UITableView components. In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints. This technique is very easy and requires very little customization. Enjoy.", image: nil,  isIncoming: true, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "This technique is very easy and requires very little customization. Enjoy.", image: nil, isIncoming: false, date: dateFromString(pattern: "08/03/2017"), audioFilePath: nil),
             Message(text: "Little short message", image: nil, isIncoming: true, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints.", image: nil,  isIncoming: false, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "Provides auto sizing using anchor constraints. This technique is very easy and requires very little customization. Enjoy.",  image: nil, isIncoming: true, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints.", image: nil,  isIncoming: false, date: dateFromString(pattern: "17/03/2017"), audioFilePath: nil),
             Message(text: "This technique is very easy and requires very little customization. Enjoy.", image: nil,  isIncoming: false, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "Little short message", image: nil,  isIncoming: true, date: dateFromString(pattern: "17/03/2017"), audioFilePath: nil),
             Message(text: "In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints.", image: nil,  isIncoming: true, date: dateFromString(pattern: "17/03/2017"), audioFilePath: nil),
             Message(text: "This technique is very easy and requires very little customization. Enjoy.",  image: nil, isIncoming: true, date: dateFromString(pattern: "17/04/2017"), audioFilePath: nil),
             Message(text: "Little short message", image: nil,  isIncoming: true, date: dateFromString(pattern: "13/03/2017"), audioFilePath: nil),
             Message(text: "In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints.",  image: nil, isIncoming: false, date: dateFromString(pattern: "13/03/2017"), audioFilePath: nil),
             Message(text: "Provides auto sizing using anchor constraints. This technique is very easy and requires very little customization. Enjoy.", image: nil,  isIncoming: false, date: dateFromString(pattern: "13/03/2017"), audioFilePath: nil),
             Message(text: "A very common task in iOS is to provide auto sizing cells for UITableView components. In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints. This technique is very easy and requires very little customization. Enjoy.", image: nil,  isIncoming: true, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "This technique is very easy and requires very little customization. Enjoy.", image: nil, isIncoming: false, date: dateFromString(pattern: "20/03/2017"), audioFilePath: nil),
             Message(text: "Little short message", image: nil,  isIncoming: true, date: dateFromString(pattern: "20/03/2017"), audioFilePath: nil),
             Message(text: "In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints.",  image: nil, isIncoming: false, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "Provides auto sizing using anchor constraints. This technique is very easy and requires very little customization. Enjoy.", image: nil,  isIncoming: true, date: dateFromString(pattern: "12/03/2017"), audioFilePath: nil),
             Message(text: "In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints.", image: nil,  isIncoming: false, date: dateFromString(pattern: "17/03/2017"), audioFilePath: nil),
             Message(text: "This technique is very easy and requires very little customization. Enjoy.", image: nil, isIncoming: false, date: dateFromString(pattern: "17/04/2017"), audioFilePath: nil),
             Message(text: "Little short message", image: nil,  isIncoming: true, date: dateFromString(pattern: "17/03/2017"), audioFilePath: nil),
             Message(text: "In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints.", image: nil,  isIncoming: true, date: dateFromString(pattern: "17/03/2017"), audioFilePath: nil)
        ]
    }
    
    public func getMockContacts() -> [Contact] {
        return [
            Contact(name: "Onur Işık", image: #imageLiteral(resourceName: "beautiful"), messages: generateMessages()),
            Contact(name: "Brain Voon", image: #imageLiteral(resourceName: "background-3"), messages: generateMessages()),
            Contact(name: "Chad Darby", image: #imageLiteral(resourceName: "beautiful"), messages: generateMessages()),
            Contact(name: "Gordon Linoff", image: #imageLiteral(resourceName: "beautiful"), messages: generateMessages()),
            Contact(name: "Martijn Pieters", image: #imageLiteral(resourceName: "beautiful"), messages: generateMessages()),
            Contact(name: "Jon Skeet", image: #imageLiteral(resourceName: "beautiful"), messages: generateMessages()),
            Contact(name: "Günter Zöchbauer", image: #imageLiteral(resourceName: "beautiful"), messages: generateMessages()),
        ]
    }
}

