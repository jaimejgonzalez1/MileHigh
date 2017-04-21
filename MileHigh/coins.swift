//
//  COINS
//  MileHigh
//
//  Created by Jaime Gonzalez on 4/11/17.
//  Copyright © 2017 columbia college. All rights reserved.
//

import UIKit
import CoreMotion

class coins: UIViewController {
    
 
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var points: UILabel!
    var days:[String] = []
    var stepsTaken:[Int] = []
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                            self.points.text = String(x*2)
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
}
    
    


