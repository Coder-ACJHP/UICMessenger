//
//  AudioRecorderManager.swift
//  UICMessenger
//
//  Created by Onur Işık on 20.04.2019.
//  Copyright © 2019 FitBest Bilgi Teknolojileri. All rights reserved.
//

import UIKit
import AVFoundation

@objc protocol AudioRecorderManagerDelegate: AnyObject {
    @objc func audioRecorder(_ audioRecorder: AudioRecorderManager, didStartToRecord: Bool)
    @objc func audioRecorder(_ audioRecorder: AudioRecorderManager, didFailToStartToRecord: Bool)
    @objc func audioRecorder(_ audioRecorder: AudioRecorderManager, didStopRecording: Bool)
    @objc func audioRecorder(_ audioRecorder: AudioRecorderManager, didFailToStopRecording: Bool)
    @objc func audioRecorder(_ audioRecorder: AudioRecorderManager, didFinishRecordingWithSuccess: Bool)
}

class AudioRecorderManager: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    static let shared = AudioRecorderManager()

    public var isCanRecord: Bool = false
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder!
    public weak var delegate: AudioRecorderManagerDelegate?
    
    override init() {
        super.init()
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.isCanRecord = true
                    } else {
                        self.isCanRecord = false
                    }
                }
            }
        } catch { self.isCanRecord = false }
    }
    
    func startRecording() {
        let audioFilename = getFileURL()
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            if !audioRecorder.isRecording { audioRecorder.record() }
            delegate?.audioRecorder(self, didStartToRecord: true)
        } catch {
            delegate?.audioRecorder(self, didFailToStartToRecord: true)
            stopRecording()
        }
    }
    
    func stopRecording() {
        if audioRecorder.isRecording {
            audioRecorder.stop()
            audioRecorder = nil
        }
    }
    
    func getFileURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0]
                                                .appendingPathComponent("AudioMessage.m4a") as URL
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            stopRecording()
            delegate?.audioRecorder(self, didFinishRecordingWithSuccess: false)
        } else {
            delegate?.audioRecorder(self, didFinishRecordingWithSuccess: true)
        }
    }
}
