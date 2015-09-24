//
//  Common.swift
//  WDChallenge
//
//  Created by Ravi Shankar on 24/09/15.
//  Copyright © 2015 Ravi Shankar. All rights reserved.
//

import Foundation

class Common {
    
    static func loadFilteredDeparments() -> [String]? {
        
        var filteredDepartments:[String]?
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let departments = userDefaults.arrayForKey("departmentsKey") {
            filteredDepartments =  departments as? [String]
        }
        return filteredDepartments
    }
}