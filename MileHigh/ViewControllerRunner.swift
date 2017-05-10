//
//  ViewControllerRunner.swift
//  MileHigh
//
//  Created by Jaime Gonzalez on 5/9/17.
//  Copyright © 2017 columbia college. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewControllerRunner: UIViewController {
    
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    var user = UserDefaults.standard
    
    
    

    @IBOutlet weak var points: UILabel!
    var days:[String] = []
    var stepsTaken:[Int] = []
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                avPlayer.play()
                paused = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            avPlayer.pause()
            paused = true
        }
    
    @objc private func playerItemDidReachEnd(notification: Notification) {
    let p: AVPlayerItem = notification.object as! AVPlayerItem
    p.seek(to: kCMTimeZero)
    }
    
    private func playVideo() {
        let theURL = Bundle.main.url(forResource:"Volume", withExtension: "mp4")
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playVideo()
        
        
        
        //        self.timer.text = String(describing: Timer())
        var cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let timeZone = TimeZone.current
        cal.timeZone = timeZone
        
        let midnightOfToday = cal.date(from: comps)!
        
        #if arch(i386) || arch(x86_64) && os(iOS)
            
            // Simulator
            
        #else
            
            // Run only in Physical Device, iOS
            
            if(CMPedometer.isStepCountingAvailable()){
                
                self.pedoMeter.startUpdates(from: midnightOfToday) { (data: CMPedometerData?, error) -> Void in
                    DispatchQueue.main.async(execute: { () -> Void in
                        if(error == nil){
                            print("\(data!.numberOfSteps)")
                            let x:Int = Int(data!.numberOfSteps)
                            self.points.text = "[" + String(x*2)+"]"
                            //self.step.text = "\(data!.numberOfSteps)"
                        }
                    })
                }
            }
        #endif
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
