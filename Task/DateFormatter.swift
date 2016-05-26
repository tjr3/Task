//
//  DateFormatter.swift
//  Task
//
//  Created by Tyler on 5/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


extension NSDate {
    func dateFormat() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        
        return dateFormatter.stringFromDate(self)
}
}