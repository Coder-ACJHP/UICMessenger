//
//  ChatsViewController.swift
//  UICMessenger
//
//  Created by Onur Işık on 17.04.2019.
//  Copyright © 2019 Coder ACJHP. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController, FloatingStartChatButtonDelegate,
                            ChatsNavigationBarDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    private let cellId = "messagesCell"
    private var contactList = [Contact]()
    
    private var tableView = UITableView(frame: .zero)
    private var containerView: FloatingStartChatButton?
    
    private var isAnimated: Bool = false
    private var headerView: ChatsNavigationBar!
    private let navigationBarHeight: CGFloat = 85
    private var navigationBarHeightConstraint: NSLayoutConstraint?

    
    private let footerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setupHeaderView()
        
        configureTableView()
        
        setupFooterView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contactList = MockContactListProvider().getMockContacts()
    }
    
    private func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChatCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(tableView)
        
        if #available(iOS 11, *) {
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomLayoutGuide.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        }
        
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
    }
    
    private func setupHeaderView() {

        headerView = ChatsNavigationBar(frame: .zero)
        view.addSubview(headerView)
        
        // Add this cover view to cover safe area space from top (this for X and upper devices)
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: navigationBarHeight))
        tempView.backgroundColor = headerView.backgroundColor
        view.insertSubview(tempView, belowSubview: headerView)

        NSLayoutConstraint.activate([
            
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topLayoutGuide.bottomAnchor.constraint(equalTo: headerView.topAnchor)
        ])
        
        navigationBarHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: navigationBarHeight)
        navigationBarHeightConstraint?.isActive = true
    }
    
    func chatsNavigationBar(_ navigationBar: ChatsNavigationBar, pressedButtonTag: Int) {
        print(pressedButtonTag)
    }
    
    private func animateNavigationBar(statusTo: ChatsNavigationBar.Status) {
        
        if statusTo == .Expanded {
            navigationBarHeightConstraint?.constant = navigationBarHeight
        } else {
            navigationBarHeightConstraint?.constant = navigationBarHeight / 2
        }
        
        self.headerView.status = statusTo
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 3,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func setupFooterView() {
        
        view.addSubview(footerView)
        
        containerView = FloatingStartChatButton(frame: .zero)
        containerView!.delegate = self
        footerView.addSubview(containerView!)
        
        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 90),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomLayoutGuide.topAnchor.constraint(equalTo: footerView.bottomAnchor),
            
            containerView!.widthAnchor.constraint(equalToConstant: 60),
            containerView!.heightAnchor.constraint(equalToConstant: 60),
            containerView!.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -22),
            containerView!.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])
    }
    
    private func removeFloatingButton() {
        containerView?.removeFromSuperview()
        containerView = nil
    }
    
    
    func floatingStartChatButtonPressed(_ FloatingStartChatButton: FloatingStartChatButton) {
        let alert = UIAlertController(title: "Hi there 👋🏻", message: "Start a new chat now!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            animateNavigationBar(statusTo: .Collapsed)
        } else {
            animateNavigationBar(statusTo: .Expanded)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatCell
        cell.contact = contactList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contact = contactList[indexPath.row]
        let chatViewController = MessagesViewController()
        chatViewController.messageList = contact.messages
        chatViewController.contact = contact
        self.presentDetail(chatViewController)
    }
}
