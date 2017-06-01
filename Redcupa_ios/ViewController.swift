//
//  ViewController.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 5/24/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler: {(FBSDKLoginManagerLoginResult, facebookError) -> Void in
            if facebookError != nil {
                print("Facebook Login failed 😕 ")
            } else if (FBSDKLoginManagerLoginResult!.isCancelled){
                print("login cncelled")
            } else{
                print("youre in 😍")
                //Trigger Segue
                
                
            }
        });
            
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

