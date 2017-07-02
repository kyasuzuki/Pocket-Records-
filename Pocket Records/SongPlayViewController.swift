//
//  SongPlayViewController.swift
//  Pocket Records
//
//  Created by Kya Suzuki on 6/28/17.
//  Copyright © 2017 Kya Suzuki. All rights reserved.
//

import UIKit
import AVFoundation

class SongPlayViewController: UIViewController {
    
    @IBAction func myCanvasButton(_ sender: UIButton) {
        
    }
    @IBOutlet weak var recordImage: UIImageView!
    
 
    
    var audioPlayer: AVAudioPlayer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (navigationItem.title == "Time For Us"){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "TimeForUs", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            recordImage.image = UIImage(named: "TimeForUs")
        }
        catch{
            print(error)
            }
        }
        if (navigationItem.title == "Little Hollywood"){
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "LittleHollywood", ofType: "mp3")!))
                audioPlayer.prepareToPlay()
                recordImage.image = UIImage(named: "LittleHollywood")
            }
            catch{
                print(error)
            }
        }
        if (navigationItem.title == "Love$ick"){
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Love$ick", ofType: "mp3")!))
                audioPlayer.prepareToPlay()
                recordImage.image = UIImage(named: "Love$ick")
            }
            catch{
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func Play(_ sender: UIButton) {
        audioPlayer.play()
    }
    
    @IBAction func Pause(_ sender: UIButton) {
        if audioPlayer.isPlaying{
            audioPlayer.pause()
        }
        else{
            
        }
    }
    
    @IBAction func Restart(_ sender: UIButton) {
        if audioPlayer.isPlaying{
            audioPlayer.stop()
            audioPlayer.play()
        }
        else{
            audioPlayer.play()
        }
    }
    
}

