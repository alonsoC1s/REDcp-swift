//
//  NewPostController.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 6/21/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import UIKit
import GoogleMaps

class NewPostController: UIViewController {
    
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var eventContentField: UITextField!
    @IBOutlet weak var eventPrivate: UISwitch!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    var passedCoordinates: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()

        print("ya se armoo")
        print(passedCoordinates!)
        
    }

    @IBAction func didTapCreateEvent(_ sender: UIButton) {
        print("We are working on your request")
    }

}
