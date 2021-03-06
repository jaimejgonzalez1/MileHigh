//
//  InterfaceController.swift
//  MileHigh WatchKit Extension
//
//  Created by Jaime Gonzalez on 5/9/17.
//  Copyright © 2017 columbia college. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var labeler: WKInterfaceLabel!
  
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
