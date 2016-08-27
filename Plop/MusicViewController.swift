//
//  MusicViewController.swift
//  Plop
//
//  Created by 김혜원 on 2016. 8. 28..
//  Copyright © 2016년 seolheelee. All rights reserved.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {

    var backgroundMusicPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicSettingFunction()
        
        startPauseButton.addTarget(self, action: #selector(startPasueFunction), forControlEvents: .TouchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var startPauseButton: UIButton!
    
    func startPasueFunction()  {
        if !backgroundMusicPlayer.playing {
            startPauseButton.setImage(UIImage(named: "music_pause.png"), forState: .Normal)
            backgroundMusicPlayer.play()
            
        } else {
            startPauseButton.setImage(UIImage(named: "music_playicon.png"), forState: .Normal)

            backgroundMusicPlayer.pause()
        }

    }
    
    func musicSettingFunction() {
        let filename = "qm1ru1-aac.mp3"
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            //            backgroundMusicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
