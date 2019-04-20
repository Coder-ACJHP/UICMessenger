//
//  MessagesViewController.swift
//  UICMessageApp
//
//  Created by Onur Işık on 17.04.2019.
//  Copyright © 2019 Coder ACJHP. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessagesNavigationBarDelegate, UITextViewDelegate {
    
    private let inputConponentContainerView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private var inputContainerViewBottomConstraint: NSLayoutConstraint?
    private let inputTextView: UITextView = {
        let textfield = UITextView(frame: .zero)
        textfield.isScrollEnabled = false
        textfield.font = UIFont.preferredFont(forTextStyle: .headline)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Enter message..."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (inputTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (inputTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !inputTextView.text.isEmpty
        return placeholderLabel
    }()
    
    private var isStartedToRecord: Bool = false
    private var audioRecorderManager: AudioRecorderManager?
    
    private static let micIcon = UIImage(named: "mic")?.withRenderingMode(.alwaysOriginal)
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(micIcon, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleButtonPress(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(handleButtonDown(_:)), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public var contact: Contact!
    private var headerView: MessagesNavigationBar!
    private let navigationBarHeight: CGFloat = 50
    
    private var tableView = UITableView(frame: .zero)
    private let messageBubleId = "messageCell"
    private let messageAudioBubleId = "messageAudioCell"
    public var messageList = [Message]() {
        didSet {
            if messageList.count == 0 {
                messages.removeAll(keepingCapacity: false)
                addMessageLabel()
            } else {
                sortMessages(grouping: messageList)
            }
            tableView.reloadData()
        }
    }
    private var messages = Array<Array<Message>>()
    
    private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupHeaderView()
        
        setupInputComponents()

        setupTableView()
        
        addBackGroundImage()
        
        configurePlaceHolder()
        
        audioRecorderManager = AudioRecorderManager()
        audioRecorderManager?.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    private func setupHeaderView() {
        
        headerView = MessagesNavigationBar(frame: .zero)
        headerView.delegate = self
        view.addSubview(headerView)
        
        // Add this cover view to cover safe area space from top (this for X and upper devices)
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: navigationBarHeight))
        tempView.backgroundColor = headerView.backgroundColor
        view.insertSubview(tempView, belowSubview: headerView)
        
        NSLayoutConstraint.activate([
            
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topLayoutGuide.bottomAnchor.constraint(equalTo: headerView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: navigationBarHeight),
        ])
        
        headerView.detail = contact.name
        headerView.title = contact.name
        headerView.icon = contact.image
    }
    
    func commonNavigationBar(_ navigationBar: MessagesNavigationBar, pressedButtonTag: Int) {
        if pressedButtonTag == 0 {
            self.dismissDetail()
        } else {
            print("Menu button pressed.")
        }
    }
    
    private func setupTableView() {

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: messageBubleId)
        tableView.register(ChatMessageAudioCell.self, forCellReuseIdentifier: messageAudioBubleId)
        self.view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: inputConponentContainerView.topAnchor).isActive = true

    }
    
    private func configurePlaceHolder() {
        inputTextView.addSubview(placeholderLabel)
    }
    
    private func setupInputComponents() {
        
        inputTextView.delegate = self
        
        view.addSubview(inputConponentContainerView)
        
        inputConponentContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        if #available(iOS 11, *) {
            
            inputConponentContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            inputConponentContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            inputContainerViewBottomConstraint = inputConponentContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            inputContainerViewBottomConstraint!.isActive = true
        } else {
            inputConponentContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            inputConponentContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            inputContainerViewBottomConstraint = bottomLayoutGuide.bottomAnchor.constraint(equalTo: inputConponentContainerView.bottomAnchor)
            inputContainerViewBottomConstraint!.isActive = true
        }

        
        inputConponentContainerView.addSubview(inputTextView)
        inputConponentContainerView.addSubview(sendButton)
        
        let borderLine = UIView()
        borderLine.backgroundColor = .lightGray
        borderLine.translatesAutoresizingMaskIntoConstraints = false
        inputConponentContainerView.addSubview(borderLine)
        
        NSLayoutConstraint.activate([
            
            sendButton.widthAnchor.constraint(equalToConstant: 50),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.trailingAnchor.constraint(equalTo: inputConponentContainerView.trailingAnchor, constant: -4),
            sendButton.centerYAnchor.constraint(equalTo: inputConponentContainerView.centerYAnchor, constant: 3),
            
            inputTextView.topAnchor.constraint(equalTo: inputConponentContainerView.topAnchor),
            inputTextView.leadingAnchor.constraint(equalTo: inputConponentContainerView.leadingAnchor, constant: 8),
            inputTextView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            inputTextView.bottomAnchor.constraint(equalTo: inputConponentContainerView.bottomAnchor),

            borderLine.widthAnchor.constraint(equalTo: inputConponentContainerView.widthAnchor),
            borderLine.heightAnchor.constraint(equalToConstant: 0.5),
            borderLine.topAnchor.constraint(equalTo: inputConponentContainerView.topAnchor),
            borderLine.centerXAnchor.constraint(equalTo: inputConponentContainerView.centerXAnchor)
        ])
        
    }
    
    fileprivate func addMessageLabel() {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 35)
        label.textColor = .lightGray
        label.text = "No messages!"
        label.textAlignment = .center
        tableView.backgroundView = label
    }
    
    fileprivate func addBackGroundImage() {
        
        tableView.backgroundView = nil
        tableView.backgroundColor = .clear
        
        let imageView = UIImageView(image: UIImage(named: "bgImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(imageView, at: 0)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        if #available(iOS 11, *) {
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            bottomLayoutGuide.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        }
    }
    
    fileprivate func sortMessages(grouping: Array<Message>) {
        
        let groupedMessages = Dictionary(grouping: grouping) { (element) -> Date in
            return element.date
        }
        
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { (key) in
            let value = groupedMessages[key]
            messages.append(value ?? [])
        }
    }
    
    private func dateFromString(pattern: String) -> Date {
        return dateFormatter.date(from: pattern) ?? Date()
    }
    
    private func getStringFromDate(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    @objc private func handleKeyboardNotification(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            
            if let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                
                let isShowing = notification.name == UIApplication.keyboardWillShowNotification
                
                var bottomInset: CGFloat = 0
                if #available(iOS 11.0, *) { bottomInset = view.safeAreaInsets.bottom }
                
                inputContainerViewBottomConstraint?.constant = isShowing ? -(keyboardFrame.height - bottomInset) : 0
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                    
                }, completion: {(_) in
                    
                    if isShowing {
                        
                        let lastSection = self.messages.count - 1
                        let lastRowInLastSection = self.messages[self.messages.count - 1].count - 1
                        let indexPath = IndexPath(row: lastRowInLastSection, section: lastSection)
                        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
                })
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        sendButton.setImage(textView.text.isEmpty ? MessagesViewController.micIcon : nil, for: .normal)
        sendButton.setTitle(textView.text.isEmpty ? nil:  "Send", for: .normal)
        placeholderLabel.isHidden = !textView.text.isEmpty
        
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        if estimatedSize.height > 50 {
            inputConponentContainerView.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height {
                    if estimatedSize.height < 90 {
                        constraint.constant = estimatedSize.height
                    } else {
                        if !textView.isScrollEnabled {
                            textView.isScrollEnabled = true
                        }
                    }
                }
            }
        }
    }
    
    @objc private func handleButtonPress(_ sender: UIButton) {
        
        let today = getStringFromDate(date: Date())
        var lastMessage: Message?
        
        if isStartedToRecord {
            self.isStartedToRecord = false
            audioRecorderManager?.stopRecording()
            placeholderLabel.text = "Enter message..."
            lastMessage = Message(text: nil,
                                  image: nil,
                                  isIncoming: false,
                                  date: dateFromString(pattern: today),
                                  audioFilePath: audioRecorderManager?.getFileURL())
            
        } else if inputTextView.text?.count ?? 0 > 0 {
            lastMessage = Message(text: inputTextView.text ?? "",
                                  image: nil,
                                  isIncoming: false,
                                  date: dateFromString(pattern: today),
                                  audioFilePath: nil)
        }
        
        let lastSection = self.messages.count - 1
        let lastRowInLastSection = self.messages[self.messages.count - 1].count
        
        messages[lastSection].append(lastMessage!)
        
        sender.titleLabel?.text = nil
        sender.setImage(MessagesViewController.micIcon, for: .normal)
        
        let insertionIndexPath = IndexPath(row: lastRowInLastSection, section: lastSection)
        tableView.insertRows(at: [insertionIndexPath], with: .automatic)
        tableView.scrollToRow(at: insertionIndexPath, at: .bottom, animated: true)
        inputTextView.text?.removeAll()
    }
    
    @objc fileprivate func handleButtonDown(_ sender: UIButton) {
        
        if audioRecorderManager!.isCanRecord
            && !isStartedToRecord
            && sender.image(for: .normal) != nil {
            
            self.isStartedToRecord = true
            audioRecorderManager?.startRecording()
            placeholderLabel.text = "Recording sound..."
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let reusableHeaderView = HeaderView()
        if let firstMessage = messages[section].first {
            reusableHeaderView.label.text = dateFormatter.string(from: firstMessage.date)
        }
        return reusableHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.section][indexPath.row]
        
        if message.audioFilePath != nil {
            let audioCell = tableView.dequeueReusableCell(withIdentifier: messageAudioBubleId, for: indexPath) as! ChatMessageAudioCell
            audioCell.chatMessage = message
            return audioCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: messageBubleId, for: indexPath) as! ChatMessageCell
        cell.chatMessage = message
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        inputTextView.endEditing(true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension MessagesViewController: AudioRecorderManagerDelegate {
    
    func audioRecorder(_ audioRecorder: AudioRecorderManager, didStartToRecord: Bool) {
        isStartedToRecord = true
    }
    
    func audioRecorder(_ audioRecorder: AudioRecorderManager, didFailToStartToRecord: Bool) {
        isStartedToRecord = false
    }
    
    func audioRecorder(_ audioRecorder: AudioRecorderManager, didStopRecording: Bool) {}
    
    func audioRecorder(_ audioRecorder: AudioRecorderManager, didFailToStopRecording: Bool) {}
    
    func audioRecorder(_ audioRecorder: AudioRecorderManager, didFinishRecordingWithSuccess: Bool) {
        isStartedToRecord = false
    }
}
