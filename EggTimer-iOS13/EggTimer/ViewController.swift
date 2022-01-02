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
    
    let eggTime = ["Soft": 3,
                    "Medium": 5,
                    "Hard": 7]
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var totalTime = 0
    var secondsPassed = 0
    
    var timer = Timer();
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // Close the timeer.
        timer.invalidate()
        
        let hardness: String = sender.currentTitle!
        
        totalTime = eggTime[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        // Start the timer.
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            print("\(secondsPassed) seconds.")
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
        } else {
            timer.invalidate();
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
            let url = Bundle.main.url(forResource: "alaarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    
}
