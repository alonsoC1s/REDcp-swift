//
//  NewPostController.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 6/21/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import FirebaseDatabase
import MaterialComponents
import FirebaseStorage
import FirebaseStorageUI

class NewPostController: UIViewController {
    
    var ref_events : DatabaseReference!
    var ref_Users : DatabaseReference!
    
    @IBOutlet weak var AuthorImage: UIImageView!
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var eventContentField: UITextField!
    @IBOutlet weak var eventIsPrivateSwitch: UISwitch!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var passedCoordinates: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref_events = Database.database().reference().child("Events_parent")
        self.ref_Users = Database.database().reference().child("Users_parent")

        //Managing date picker
    
        //Updating UI with user data
        populateUserData(firebaseUID: getCurrentFirebaseID())
        
        
    }

    @IBAction func didTapCreateEvent(_ sender: UIButton) {
        let eventName = eventNameField.text!
        let eventContent = eventContentField.text!
        let eventPrivate = eventIsPrivateSwitch.isOn
        
        //Initiate post creation TIME NOT YET FUNCTIONAL
        createPost(userID: getCurrentFirebaseID(), title: eventName, content: eventContent, lat: (passedCoordinates?.latitude)!, lng: (passedCoordinates?.longitude)!, year: 2017, month: 8, day: 22, hour: 6, minute: 20, eventIsPrivate: eventPrivate)
    }

    
    func createPost(userID: String, title: String, content: String, lat: Double, lng: Double, year: Int, month: Int, day: Int, hour: Int, minute: Int, eventIsPrivate: Bool){
        
        let pushKey = ref_events.childByAutoId().key
        
        let selectedDate : [String: Int] = [
            "year": year,
            "month": month,
            "day": day,
            "hours": hour,
            "minutes": minute
        ]

        
        if eventIsPrivate{
            //Create dictionary. Event is private
            
            let post : [String : Any] = ["eventName": title,
                        "eventContent": content,
                        "userID": userID,
                        "eventLatitude": lat,
                        "eventLongitude": lng,
                        "eventPublic": false,
                        "eventID": pushKey,
                        "eventDate": selectedDate
                        
            ]
            
            //Post to firebase
            self.ref_events.child(pushKey).setValue(post)
        } else{
            
            let post : [String : Any] = ["eventName": title,
                                         "eventContent": content,
                                         "userID": userID,
                                         "eventLatitude": lat,
                                         "eventLongitude": lng,
                                         "eventPublic": false,
                                         "eventID": pushKey,
                                         "eventDate": selectedDate
                
            ]
            
            //Post to firebase
            self.ref_events.child(pushKey).setValue(post)

        }
        //Notify operation completed. Create snackbar
        let message = MDCSnackbarMessage()
        message.text = "Post created!"
        MDCSnackbarManager.show(message)
        
        //Tigger segue to return to main screen
        performSegue(withIdentifier: "ReturnFromNewPost", sender: self)
        
    }
    
    func getCurrentFirebaseID() -> String{
        let userID = Auth.auth().currentUser?.uid
        return userID!
    }
    
    func populateUserData(firebaseUID: String){
        
        ref_Users.child(firebaseUID).observe(.value, with:{
            (snapshot) in
            let myUser = snapshot.value as! [String: AnyObject]
            let myUserFirstName = myUser["displayName"] as! String
            let myUserSecondName = myUser["displaySecondName"] as! String
            let myUsername = myUserFirstName + " " + myUserSecondName
            
            print(myUsername)
            self.usernameLabel.text = myUsername
            
        }, withCancel: nil)
        
        
        //Getting user image
        let fbStorage = Storage.storage().reference()
        let storRef = fbStorage.child(firebaseUID).child("profile_picture.jpg")
        
        self.AuthorImage.sd_setImage(with: storRef)
    }

}
