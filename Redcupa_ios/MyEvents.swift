//
//  MyEvents.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 6/20/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Event: NSObject {
    public var eventLatitude: Double!
    public var eventLongitude: Double!
    public var eventName: String!
    public var userID: String!
    public var eventContent: String!
    public var eventID: String!
    //public var attendance_list: Dictionary<String, String>
    //public var invitee_list: Dictionary<String, String>
    public var eventPublic: Bool!
    public var eventDate: MyDate!
    
    init(name: String, content: String, userID: String, lat: Double, lng: Double, eventPublic: Bool, eventID: String, year: Int, month: Int, day: Int, hour: Int, minute: Int){
        self.userID = userID
        self.eventName = name
        self.eventContent = content
        self.eventLatitude = lat
        self.eventLongitude = lng
        self.eventPublic = eventPublic
        self.eventID = eventID
        
        self.eventDate = MyDate(year: year,month: month,day: day,hour: hour,minute: minute)
        
    }
    
    public func getLatitude() -> Double{ return self.eventLatitude}
    public func getLongitude() -> Double{ return self.eventLongitude}
    
    init?(snapshot: DataSnapshot){
        
    }
    

    
}
