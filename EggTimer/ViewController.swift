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
//    lazy var audio: AVPlayer!
    lazy var url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    lazy var audio: AVPlayer! = AVPlayer.init(url: url!)

    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 5]

    var totalTime: Float = 0
    var secondsPassed: Float = 0
    
    var timerObj = Timer()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timerObj.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0.0
        audio.pause()
        audio.seek(to: .zero)
        let hardness = sender.currentTitle!
        
        titleLabel.text = hardness
        
        totalTime = Float(eggTimes[hardness]!)
        timerObj = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
                
    }
    
    @objc func updateCounter() {
        let percent = Float(secondsPassed) / Float(totalTime)
        progressBar.setProgress(percent, animated: true)
        if secondsPassed < totalTime {
            secondsPassed += 1
        } else {
            timerObj.invalidate()
            audio.play()
            titleLabel.text = "DONE!"
        }
    }
}
