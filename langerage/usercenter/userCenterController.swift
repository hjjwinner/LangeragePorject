//
//  userCenterController.swift
//  langerage
//
//  Created by autonavi on 16/2/19.
//  Copyright © 2016年 langerage. All rights reserved.
//

import Foundation
import UIKit

class userCenterController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        
        let db = LASQLite.sharedInstance
        
        let list = db.countryList()
        
//        print(list)

        
    }
    
}