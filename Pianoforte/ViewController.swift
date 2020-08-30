//
//  ViewController.swift
//  Pianoforte
//
//  Created by George Yu on 2018-12-31.
//  Copyright © 2018 George Yu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var sustain = false
    
    var audioPlayer1 = AVAudioPlayer()
    
    var audioPlayers = ["C3": AVAudioPlayer(),
                        "D": AVAudioPlayer(),
                        "E": AVAudioPlayer(),
                        "F": AVAudioPlayer(),
                        "G": AVAudioPlayer(),
                        "A": AVAudioPlayer(),
                        "B": AVAudioPlayer(),
                        "C4": AVAudioPlayer(),
                        "C#": AVAudioPlayer(),
                        "D#": AVAudioPlayer(),
                        "F#": AVAudioPlayer(),
                        "G#": AVAudioPlayer(),
                        "A#": AVAudioPlayer()]
    
    var beingPressed = ["C3": false,
                        "D": false,
                        "E": false,
                        "F": false,
                        "G": false,
                        "A": false,
                        "B": false,
                        "C4": false,
                        "C#": false,
                        "D#": false,
                        "F#": false,
                        "G#": false,
                        "A#": false]
    
    @IBOutlet var notes: [UIButton]!
    let references = ["C3", "D", "E", "F", "G", "A", "B", "C4", "C#", "D#", "F#", "G#", "A#"]
    
    @IBAction func sustainPressed(_ sender: UIButton) {
        sustain = true
        sender.backgroundColor = UIColor(named: "darkRed")
    }
    
    @IBAction func sustainLifted(_ sender: UIButton) {
        sustain = false
        sender.backgroundColor = UIColor(named: "red")
        for note in references {
            if (beingPressed[note] == false) {
                audioPlayers[note]?.stop()
            }
        }
    }
    
    @IBAction func notePressed(_ sender: UIButton) {
        play(note: notes.firstIndex(of: sender)! + 1)
        beingPressed[sender.currentTitle!]! = true
        if (sender.backgroundColor == UIColor.white) {
            sender.backgroundColor = UIColor(named: "lightGray")
        } else if (sender.backgroundColor == UIColor.black) {
            sender.backgroundColor = UIColor(named: "darkGray")
        }
    }
    
    @IBAction func noteLifted(_ sender: UIButton) {
        if (sustain == false) {
            audioPlayers[sender.currentTitle!]!.stop()
        }
        beingPressed[sender.currentTitle!]! = false
        if (sender.backgroundColor == UIColor(named: "lightGray")) {
            sender.backgroundColor = UIColor.white
        } else if (sender.backgroundColor == UIColor(named: "darkGray")) {
            sender.backgroundColor = UIColor.black
        }
    }
    
    func play(note: Int) {
        let reference = references[note - 1]
        if let path = Bundle.main.path(forResource: reference, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayers[reference] = try AVAudioPlayer(contentsOf: url)
                audioPlayers[reference]!.prepareToPlay()
                audioPlayers[reference]!.play()
            } catch {
                
            }
        }
    }
    
}
