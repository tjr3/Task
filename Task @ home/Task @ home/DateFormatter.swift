//
//  DateFormatter.swift
//  Task @ home
//
//  Created by Tyler on 5/29/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import Foundation

extension NSDate {
    func dateFormat() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        
        return dateFormatter.stringFromDate(self)
}
}