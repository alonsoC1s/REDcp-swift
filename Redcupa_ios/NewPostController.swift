//
//  ViewController.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 6/20/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GooglePlaces
import GoogleMaps


class NewPostController: UIViewController {
    
    var ref_events: DatabaseReference!
    
    @IBOutlet weak var EventNameField: UITextField!
    @IBOutlet weak var EventContentField: UITextField!
    @IBOutlet weak var EventPrivateSwitch: UISwitch!
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    var passedCoordinates: CLLocationCoordinate2D? 

    override func viewDidLoad() {
        super.viewDidLoad()

        print("ya se armo")
        print(passedCoordinates)
        
    }
    
    
    @IBAction func didTapCreateNewPost(_ sender: Any) {
        
        self.ref_events = Database.database().reference().child("Events_parent")
        
        //Get unique post id
        let eventID = self.ref_events.childByAutoId().key
        
    }
    func writeNewPost(){
        
    }
    /*
 // Finish this Activity, back to the stream
 _ = self.navigationController?.popViewController(animated: true)
*/
    
}
