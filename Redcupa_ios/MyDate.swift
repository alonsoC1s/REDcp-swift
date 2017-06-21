//
//  MyDate.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 6/20/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import Foundation
class MyDate: NSObject {
    public var year: Int
    public var month: Int
    public var day: Int
    public var hour: Int
    public var minute: Int
    
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int){
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute 

    }
}
