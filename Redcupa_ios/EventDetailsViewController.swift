//
//  EventDetailsViewController.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 7/3/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    var obtainedEvent: Event!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func setupWithEvent( obtainedEvent: Event){
        print(obtainedEvent.getEventName())
    }


}
