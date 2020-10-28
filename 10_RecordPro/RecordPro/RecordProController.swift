//
//  RecordProController.swift
//  RecordPro
//
//  Created by Simon Ng on 11/10/2019.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import AVFoundation

//extension RecordProController: AVAudioRecorderDelegate {
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfullyflag: Bool)
//}



class RecordProController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    @IBOutlet private var stopButton: UIButton!
    @IBOutlet private var playButton: UIButton!
    @IBOutlet private var recordButton: UIButton!
    @IBOutlet private var timeLabel: UILabel!
    
    private var timer: Timer?
    private var elapsedTimeInSecond: Int = 0
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Action methods
    
    @IBAction func stop(sender: UIButton) {
        
        recordButton.setImage(UIImage(named: "Record"), for: UIControl.State.normal)
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        playButton.isEnabled = true
        
        audioRecorder?.stop()
        resetTimer()
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setActive(false)
            
        } catch {
            print(error)
        }
        
    }

    @IBAction func play(sender: UIButton) {
        
        if !audioRecorder.isRecording {
            guard let player = try? AVAudioPlayer(contentsOf: audioRecorder.url) else {
                print("Failed to initialize AVAudioPlayer")
                return
            }
            audioPlayer = player
            audioPlayer?.delegate = self
            audioPlayer?.play()
            startTimer()
        }
        
    }

    @IBAction func record(sender: UIButton) {
        
        if let player = audioPlayer, player.isPlaying {
            player.stop()
        }
        
        if !audioRecorder.isRecording {
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setActive(true)
                
                audioRecorder.record()
                startTimer()
                
                recordButton.setImage(UIImage(named: "Pause"), for: UIControl.State.normal)
                
            } catch {
                print(error)
            }
            
        } else {
            audioRecorder.pause()
            pauseTimer()
            
            recordButton.setImage(UIImage(named: "Record"), for: UIControl.State.normal)
        }
        
        stopButton.isEnabled = true
        playButton.isEnabled = false
        
    }
    
    private func configure() {
        stopButton.isEnabled = false
        playButton.isEnabled = false
        
        guard let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else {
            
            let alertMessage = UIAlertController(title: "Error", message: "Failed to get the document directory for recording the audio. Please try again later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertMessage, animated: true, completion: nil)
            
            return
        }
        
        let audioFileURL = directoryURL.appendingPathComponent("MyAudioMemo.m4a")
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [ .defaultToSpeaker ])
            
            let recorderSetting: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: recorderSetting)
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            
        } catch {
            print(error)
        }
      }

    internal func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            let alertMessage = UIAlertController(title: "Finish Recording", message: "Successfully recorded the audio!", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertMessage, animated: true, completion: nil)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool ) {
        playButton.isSelected = false
        
        let alertMessage = UIAlertController(title: "Finish Playing", message: "Finish playing the recording!", preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertMessage, animated: true, completion: nil)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.elapsedTimeInSecond += 1
            self.updateTimeLabel()
                    })
    }
    
    func pauseTimer() {
        timer?.invalidate()
       
    }
    
    func resetTimer() {
        timer?.invalidate()
        elapsedTimeInSecond = 0
        updateTimeLabel()
        audioRecorder?.stop()
    }
    
    func updateTimeLabel() {
        
        let seconds = elapsedTimeInSecond % 60
        let minutes = (elapsedTimeInSecond / 60) % 60
        
        timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
}
