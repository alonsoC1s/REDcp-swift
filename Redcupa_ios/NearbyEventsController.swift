//
//  NearbyEventsController.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 6/26/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NearbyEventsController: UITableViewController {
    
    var ref_Events: DatabaseReference!
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EventCell.self, forCellReuseIdentifier: "cellID")
        
        self.ref_Events = Database.database().reference().child("Events_parent")

        fetchEvents()
    }
    
    func fetchEvents(){
        ref_Events.observe(.childAdded, with: {(snapshot) in
            let event = Event(snapshot: snapshot)
            
            self.events.append(event!)
            
            //Update cells
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
            
            
        })
    }



    //Returns the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
        
    }
    
    //This function populates the data inside the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        let event = events[indexPath.row]
        
        //Setting cell values
        cell.textLabel?.text = event.getEventName()
        cell.detailTextLabel?.text = event.getEventContent()
        cell.imageView?.image = UIImage.init(named: "icon.jpg")
        
        
        return cell
        
    }

}

class EventCell: UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
