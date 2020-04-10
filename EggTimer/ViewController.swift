//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // dict of cook times (min) * 60, depending on egg hardness
    let cookTimes: [String: Int] = ["Soft": 5 * 60, "Medium": 7 * 60, "Hard": 12 * 60]
    
    // remaining seconds for egg to finish cooking
    var secondsRemaining: Int = 0
    
    var timer = Timer()
    
    var audioPlayer: AVAudioPlayer? = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBar.progress = 0.0
    }
    
    // triggered when any button is pressed
    @IBAction func buttonTouchUp(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        let cookTime = cookTimes[hardness]!
        
        // reset timer
        timer.invalidate()
        
        // set top label to in progress
        topLabel.text = "\(hardness)..."
        
        
        // set progressBar progress to 0 %
        progressBar.progress = 0.0
        
        // get time to cook an egg
        secondsRemaining = cookTime
        
        // tick timer every second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsRemaining > 1 {
                // update secondsRemaining value
                self.secondsRemaining -= 1
                
                // set progressBar progress according to remaining seconds
                let value = Float(cookTime - self.secondsRemaining) / Float(cookTime)
                self.progressBar.progress = value
                
            } else {
                // reset timer
                self.timer.invalidate()
                
                // set top label to DONE
                self.topLabel.text = "DONE :)"
                
                // set progressBar progress to 100%
                self.progressBar.progress = 1.0
                
                self.play_sound(soundName: "alarm_sound")
            }
        }
    }
    
    // function that plays wav sound of name given as parameter
    func play_sound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else
        { return }
        
        do {
            // sound will play even if phone is silenced
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = audioPlayer else { return }
            
            // start playing sound
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
