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
import FirebaseDatabase
import FirebaseFacebookAuthUI
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleMaps
import Material


class MyMapView: UIViewController, FUIAuthDelegate {
    
    var ref_events : DatabaseReference!
    var events = [Event]()
    var googleMapView: GMSMapView?
    
    override func loadView() {
        
        self.ref_events = Database.database().reference().child("Events_parent")

    
        let camera = GMSCameraPosition.camera(withLatitude: 19.0412967, longitude: -98.20619959999999, zoom: 11)
        let googleMapView = GMSMapView.map(withFrame: .zero, camera: camera)
        googleMapView.isMyLocationEnabled = true
        
 
        //Firebase querying for event data. Cannot be done on outside function as marker drawing is 
        // only supported from within loadView()
        ref_events.observe(.childAdded, with: { (snapshot) in
            
            
            let event = snapshot.value as! [String:AnyObject]
            let eventLat = event["eventLatitude"] as! Double
            let eventLng = event["eventLongitude"] as! Double
            let eventName = event["eventName"] as! String
            
            let position = CLLocationCoordinate2D(latitude: eventLat, longitude: eventLng)
            let marker = GMSMarker(position: position)
            marker.title = eventName
            
            marker.map = googleMapView
            
        }, withCancel: nil)
        //End Firebase querying. 
        //Note: .observe() functions are called asynchronous, so called last.
        
        
        self.view = googleMapView
    }
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        checkLoggedIn()
        
    }
    
    func checkLoggedIn() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                
            } else {
                // No user is signed in.
                self.login()
            }
        }
    }
    
    func login() {
        //TODO: Add users to database under Users_parent
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
    
        let options = FirebaseApp.app()?.options
        let clientId = options?.clientID
        
        let facebookProvider = FUIFacebookAuth()
        
        authUI?.providers = [facebookProvider]
        
        let authViewController = authUI?.authViewController()
        self.present(authViewController!, animated: true, completion: nil)
    }
    

    @IBAction func logOut(_ sender: UIButton) {
        try! Auth.auth().signOut()
    }
 
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if error != nil {
            //Problem signing in
            login()
        }else {
            //User is in! Here is where we code after signing in
            
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }

}

