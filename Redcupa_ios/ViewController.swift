//
//  ViewController.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 5/24/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuthUI
import FirebaseFacebookAuthUI
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    var kFacebookAppID = "PLACE YOUR 16-DIGIT FACEBOOK SECRET HERE (FOUND IN FIREBASE CONSOLE UNDER AUTHENTICATION)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FIRApp.configure()
        checkLoggedIn()
        
        
    }
    
    func checkLoggedIn() {
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if user != nil {
                // User is signed in.
            } else {
                // No user is signed in.
                self.login()
            }
        }
    }
    
    func login() {
        let auth = authui
        let authUI = FIRAuthUI.init(auth: FIRAuth.auth()!)
        let options = FIRApp.defaultApp()?.options
        let clientId = options?.clientID
        let googleProvider = FIRGoogleAuthUI(clientID: clientId!)
        let facebookProvider = FIRFacebookAuthUI(appID: kFacebookAppID)
        authUI?.delegate = self
        authUI?.providers = [googleProvider, facebookProvider]
        let authViewController = authUI?.authViewController()
        self.present(authViewController!, animated: true, completion: nil)
    }
    
    @IBAction func logoutUser(_ sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
    }
    
    func authUI(_ authUI: FIRAuthUI, didSignInWith user: FIRUser?, error: Error?) {
        if error != nil {
            //Problem signing in
            login()
        }else {
            //User is in! Here is where we code after signing in
            
        }
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionUniversalLinksOnly] as! String
        return FIRAuthUI.default()!.handleOpen(url as URL, sourceApplication: sourceApplication )
    }

}

