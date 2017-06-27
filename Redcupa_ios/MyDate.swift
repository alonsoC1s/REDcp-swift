//
//  MyDate.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 6/20/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import Foundation
class MyDate: NSObject{
    public var year: Int
    public var month: Int
    public var day: Int
    public var hour: Int
    public var minute: Int
    
    init(dateDictionary: [String:AnyObject] ){
        self.year = dateDictionary["year"] as! Int
        self.month = dateDictionary["month"] as! Int
        self.day = dateDictionary["day"] as! Int
        self.hour = dateDictionary["hours"] as! Int
        self.minute = dateDictionary["minutes"] as! Int 
    }
}
