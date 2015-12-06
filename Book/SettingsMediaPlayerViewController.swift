//
//  SettingsMediaPlayerViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/3/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsMediaPlayerViewController: UIViewController {
    
    var playerItem = AVAudioPlayer()
    var currentlyPlaying = false
    var timer:NSTimer!
    
    var currentlyPlayingFile : String?
    
    var sounds: [String: String] = ["coffee": "coffeeBackground", "thunder": "thunderBackground", "rainforest": "rainforestBackground"]
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlayerFile()
    }
    
    override func viewDidDisappear(animated: Bool) {
        playerItem.stop()
        currentlyPlaying = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            playerItem.stop()
            setPlayerFile()
            startPlaying()
            setBackground()
        }
    }
    
    @IBAction func pressedPlayPauseButton(sender: UIButton) {
        if currentlyPlaying {
            pausePlaying()
        } else {
            startPlaying()
            setBackground()
        }
    }
    
    func updateTime() {
        progressView?.progress = Float(playerItem.currentTime / playerItem.duration)
    }
    
    func setPlayerFile() {
        let randomIndex: Int = Int(arc4random_uniform(UInt32(sounds.count)))
        let randomSoundKey = Array(sounds.keys)[randomIndex]
        let path = NSBundle.mainBundle().URLForResource(randomSoundKey, withExtension: "mp3")
        currentlyPlayingFile = randomSoundKey
        do {
            try playerItem = AVAudioPlayer(contentsOfURL: path!)
        } catch let error as NSError {
            print("Could not set audio file because: \(error)")
        }
    }
    
    func startPlaying() {
        playPauseButton.setImage(UIImage(named: "pauseIcon.png"), forState: .Normal)
        playerItem.play()
        currentlyPlaying = true
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }
    
    func pausePlaying() {
        playPauseButton.setImage(UIImage(named: "playIcon.png"), forState: .Normal)
        playerItem.pause()
        currentlyPlaying = false
    }
    
    func setBackground() {
        switch currentlyPlayingFile! {
        case "coffee":
            backgroundImage.image = UIImage(named: "coffeeBackground.jpg")
        case "rainforest":
            backgroundImage.image = UIImage(named: "rainforestBackground.jpg")
        case "thunder":
            backgroundImage.image = UIImage(named: "thunderBackground.jpg")
        default:
            backgroundImage.image = UIImage(named: "coffeeBackground.jpg")
        }

    }
    

}
