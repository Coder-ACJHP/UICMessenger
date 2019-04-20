//
//  ChatMessageAudioCellTableViewCell.swift
//  UICMessenger
//
//  Created by Onur Işık on 20.04.2019.
//  Copyright © 2019 FitBest Bilgi Teknolojileri. All rights reserved.
//

import UIKit
import AVFoundation

class ChatMessageAudioCell: UITableViewCell, AVAudioPlayerDelegate {

    private var audioPlayer:AVAudioPlayer!
    private static let playIcon = UIImage(named: "play")?.withRenderingMode(.alwaysOriginal)
    private static let pauseIcon = UIImage(named: "pause")?.withRenderingMode(.alwaysOriginal)
    private static let errorIcon = UIImage(named: "error")?.withRenderingMode(.alwaysOriginal)
    private let playButton = UIButton(type: .system)
    private let messageLabel = UILabel()
    
    private let bubleView = UIView()
    private let bubbleImageView: UIImageView = {
        return UIImageView()
    }()
    
    public var chatMessage: Message! {
        didSet {
            if chatMessage.isIncoming {
                bubbleImageView.image = ChatMessageCell.grayBubble
                trailingConstraint.isActive = false
                leadingConstraint.isActive = true
            } else {
                bubbleImageView.image = ChatMessageCell.greenBubble
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
            preparePlayer(withFileURL: chatMessage.audioFilePath!)
        }
    }

    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    
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
        
        bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
        bubleView.addSubview(bubbleImageView)
        
        playButton.imageView?.contentMode = .scaleAspectFit
        playButton.setBackgroundImage(ChatMessageAudioCell.playIcon, for: .normal)
        playButton.addTarget(self, action: #selector(handlePlay(_:)), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        bubleView.addSubview(playButton)
        
        messageLabel.textColor = .darkGray
        messageLabel.font = UIFont.boldSystemFont(ofSize: 15)
        messageLabel.text = "Audio message."
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        bubleView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            
            bubleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            bubleView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            bubleView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubbleImageView.topAnchor.constraint(equalTo: bubleView.topAnchor),
            bubbleImageView.leadingAnchor.constraint(equalTo: bubleView.leadingAnchor, constant: -12),
            bubbleImageView.bottomAnchor.constraint(equalTo: bubleView.bottomAnchor),
            bubbleImageView.trailingAnchor.constraint(equalTo: bubleView.trailingAnchor, constant: 12),
            
            playButton.widthAnchor.constraint(equalToConstant: 45),
            playButton.heightAnchor.constraint(equalToConstant: 45),
            playButton.centerYAnchor.constraint(equalTo: bubleView.centerYAnchor),
            playButton.leadingAnchor.constraint(equalTo: bubleView.leadingAnchor),
            
            messageLabel.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 4),
            messageLabel.centerYAnchor.constraint(equalTo: bubleView.centerYAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: bubleView.trailingAnchor, constant: 10),
            messageLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        leadingConstraint = bubleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = false
        trailingConstraint = bubleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func handlePlay(_ sender: UIButton) {
        if !audioPlayer.isPlaying {
            playAudio()
        } else {
            stopAudio()
        }
    }
    
    private func preparePlayer(withFileURL: URL) {

        do {
            let isReachable = try withFileURL.checkResourceIsReachable()
            
            if isReachable {
                if withFileURL.absoluteString.contains("AudioMessage.m4a") {
                    
                    audioPlayer = try AVAudioPlayer(contentsOf: withFileURL)
                    audioPlayer.delegate = self
                    audioPlayer.prepareToPlay()
                    audioPlayer.volume = 10.0
                } else {
                    deinitializePlayer()
                    print("An error occured; unsupoorted file format!")
                }
            } else {
                deinitializePlayer()
                print("An error occured; couldnt load file!")
            }
        } catch let error {
            deinitializePlayer()
            print(error.localizedDescription)
        }
    }
    
    
    
    private func deinitializePlayer() {
        audioPlayer = nil
        playButton.isEnabled = false
        playButton.alpha = 0.5
        messageLabel.text = "An error occured!"
        playButton.setBackgroundImage(ChatMessageAudioCell.errorIcon, for: .normal)
    }
    
    func playAudio() {
        playButton.setBackgroundImage(ChatMessageAudioCell.pauseIcon, for: .normal)
        audioPlayer.play()
    }
    
    func stopAudio() {
        audioPlayer.stop()
        playButton.setBackgroundImage(ChatMessageAudioCell.playIcon, for: .normal)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            playButton.setBackgroundImage(ChatMessageAudioCell.playIcon, for: .normal)
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        playButton.setBackgroundImage(ChatMessageAudioCell.errorIcon, for: .normal)
        print("audioPlayerDecodeErrorDidOccur method called.", error!.localizedDescription)
    }
    
    deinit {
        deinitializePlayer()
    }
    
}
