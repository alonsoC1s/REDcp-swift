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
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! EventCell
        
        let event = events[indexPath.row]
        
        //Getting image from firebase 
        let storage = Storage.storage()
        let profilePRef = storage.reference().child(event.getAuthorUID()).child("profile_picture.png")
        
        //Setting cell values
        cell.textLabel?.text = event.getEventName()
        
        cell.detailTextLabel?.text = event.getEventContent()
        cell.profileImageView.sd_setImage(with: profilePRef )
        
        
        
        return cell
        
    }
    
    var eventDetails: EventDetailsViewController!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cool")
        present(EventDetailsViewController(), animated: true) {
            self.eventDetails?.setupWithEvent(obtainedEvent: self.events[indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

class EventCell: UITableViewCell{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Moving text labels so they dont overlap with image
        textLabel?.frame = CGRect(x: 80, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 80, y: detailTextLabel!.frame.origin.y, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
        detailTextLabel!.numberOfLines = 3
        detailTextLabel?.lineBreakMode = .byCharWrapping
        
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        
        //Constraints for profile image view
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

