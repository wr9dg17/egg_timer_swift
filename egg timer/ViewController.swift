//
//  ViewController.swift
//  egg timer
//
//  Created by Farid Hamzayev on 14.07.23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var progressBar: UIProgressView!
  
  let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 7]
  var timer = Timer()
  var totalTime = 0
  var secondsPassed = 0
  var player: AVAudioPlayer!
  
  @IBAction func hardnessSelected(_ sender: UIButton) {
    let hardness = sender.currentTitle!

    totalTime = eggTimes[hardness]!
    secondsPassed = 0
    progressBar.progress = 0.0
    titleLabel.text = hardness

    timer.invalidate()
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    playSound()
  }
  
  @objc func updateTimer() {
    if secondsPassed < totalTime {
      secondsPassed += 1
      progressBar.progress = Float(secondsPassed) / Float(totalTime)
    } else {
      timer.invalidate()
      titleLabel.text = "DONE!"
    }
  }
  
  func playSound() {
    let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
  }

}

