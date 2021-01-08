//
//  SimpleVideoCamController.swift
//  SimpleVideoCam
//
//  Created by Simon Ng on 17/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class SimpleVideoCamController: UIViewController {

    let captureSession = AVCaptureSession()
    
    var currentDevice: AVCaptureDevice!
    var videoFileOutput: AVCaptureMovieFileOutput!
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var isRecording = false
    
    @IBOutlet var cameraButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    // MARK: - Action methods
    
    @IBAction func unwindToCamera(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func capture(sender: AnyObject) {
        
        if !isRecording {
           isRecording = true
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: { () -> Void in
                self.cameraButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }, completion: nil)
            
            let outputPath = NSTemporaryDirectory() + "output.mov"
            let outputFileURL = URL(fileURLWithPath: outputPath)
            videoFileOutput?.startRecording(to: outputFileURL, recordingDelegate: self)
        } else {
            isRecording = false
            UIView.animate(withDuration: 0.5, delay: 1.0, options: [], animations: { () -> Void in
                self.cameraButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
            
            cameraButton.layer.removeAllAnimations()
            videoFileOutput?.stopRecording()
            }
        }

    private func configure() {
        
        
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        
        currentDevice = device
        
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: currentDevice) else {
            return
        }
        
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        videoFileOutput = AVCaptureMovieFileOutput()
        captureSession.addInput(captureDeviceInput)
        captureSession.addOutput(videoFileOutput)
        
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(cameraPreviewLayer!)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.frame = view.layer.frame
        
        view.bringSubviewToFront(cameraButton)
        captureSession.startRunning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "playVideo" {
    let videoPlayerViewController = segue.destination as! AVPlayerViewController
    let videoFileURL = sender as! URL
    videoPlayerViewController.player = AVPlayer(url: videoFileURL)
    }
    }
}
    extension SimpleVideoCamController: AVCaptureFileOutputRecordingDelegate {
        func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
            guard error == nil else {
                print(error ?? "")
                return
            }
            performSegue(withIdentifier: "playVideo", sender: outputFileURL)
        }
    }
    
    


