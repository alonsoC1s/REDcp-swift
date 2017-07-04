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
    
    /*
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
 */
    
    init?(snapshot: DataSnapshot){
        if let dictionary = snapshot.value as? [String: AnyObject]{
            self.eventLatitude = dictionary["eventLatitude"] as! Double
            self.eventLongitude = dictionary["eventLongitude"] as! Double
            self.eventName = dictionary["eventName"] as! String
            self.eventContent = dictionary["eventContent"] as! String
            self.userID = dictionary["userID"] as! String
            self.eventID = dictionary["eventID"] as! String
            self.eventPublic = dictionary["eventPublic"] as! Bool
            //self.eventDate = dictionary["eventDate"] as! MyDate
        }
    }
    
    
    public func getLatitude() -> Double{ return self.eventLatitude}
    public func getLongitude() -> Double{ return self.eventLongitude}
    public func getEventName() -> String{ return self.eventName}
    public func getEventContent() -> String{ return self.eventContent}
    public func getAuthorUID() -> String { return self.userID } 
    
    

    
}
