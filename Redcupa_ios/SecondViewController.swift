//
//  SecondViewController.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 6/19/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import UIKit
import FirebaseFacebookAuthUI
import FirebaseAuth

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logMeOut(_ sender: UIButton) {
        try! Auth.auth().signOut()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
