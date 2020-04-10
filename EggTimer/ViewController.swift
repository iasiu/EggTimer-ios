//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var topLabel: UILabel!
    
    // dict of cook times (min) * 60, depending on egg hardness
    let cookTimes: [String: Int] = ["Soft": 5 * 60, "Medium": 7 * 60, "Hard": 12 * 60]
    
    // remaining seconds for egg to finish cooking
    var secondsRemaining: Int = 0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // triggered when any button is pressed
    @IBAction func buttonTouchUp(_ sender: UIButton) {
        // reset timer
        timer.invalidate()
        
        topLabel.text = "Wait for it..."
        
        // get time to cook an egg
        secondsRemaining = cookTimes[sender.currentTitle!]!
        
        // tick timer every second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsRemaining > 0 {
                print("\(self.secondsRemaining) seconds.")
                self.secondsRemaining -= 1
            } else {
                self.timer.invalidate()
                self.topLabel.text = "DONE :)"
            }
        }
    }

}
