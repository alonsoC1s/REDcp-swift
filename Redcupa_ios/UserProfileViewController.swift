//
//  ViewController.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 6/22/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import UIKit
import LFTwitterProfile
import Firebase

class UserProfileViewController: TwitterProfileViewController {
    
    var tweetTableView: UITableView!
    var photosTableView: UITableView!
    var favoritesTableView: UITableView!
    var ref_Users: DatabaseReference!
    
    var custom: UIView!
    var label: UILabel!
    
    
    override func numberOfSegments() -> Int {
        return 2
    }
    
    override func segmentTitle(forSegment index: Int) -> String {
        return "Segment \(index)"
    }
    
    override func prepareForLayout() {
        //Establish Firebase db reference 
        self.ref_Users = Database.database().reference().child("Users_parent")
        
        populateUserData(firebaseUID: getCurrentFirebaseID())
        
        // TableViews
        let _tweetTableView = UITableView(frame: CGRect.zero, style: .plain)
        self.tweetTableView = _tweetTableView
        
        let _photosTableView = UITableView(frame: CGRect.zero, style: .plain)
        self.photosTableView = _photosTableView
        
        let _favoritesTableView = UITableView(frame: CGRect.zero, style: .plain)
        self.favoritesTableView = _favoritesTableView
        
        self.setupTables()
    }
    
    func populateUserData(firebaseUID: String){
        
        ref_Users.child(firebaseUID).observe(.value, with:{
            (snapshot) in
            let myUser = snapshot.value as! [String: AnyObject]
            let myUserFirstName = myUser["displayName"] as! String
            let myUserSecondName = myUser["displaySecondName"] as! String
            let myUsername = myUserFirstName + " " + myUserSecondName
            
            self.username = myUsername
            
        }, withCancel: nil)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationString = "Mexico"
        self.profileImage = UIImage.init(named: "icon.png")
    }
    
    override func scrollView(forSegment index: Int) -> UIScrollView {
        switch index {
        case 0:
            return tweetTableView
        case 1:
            return photosTableView
        case 2:
            return favoritesTableView
        default:
            return tweetTableView
        }
    }
    
    func getCurrentFirebaseID() -> String{
        let userID = Auth.auth().currentUser?.uid
        return userID!
    }
}



// MARK: UITableViewDelegates & DataSources
extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func setupTables() {
        self.tweetTableView.delegate = self
        self.tweetTableView.dataSource = self
        self.tweetTableView.register(UITableViewCell.self, forCellReuseIdentifier: "tweetCell")
        
        self.photosTableView.delegate = self
        self.photosTableView.dataSource = self
        //self.photosTableView.isHidden = true
        self.photosTableView.register(UITableViewCell.self, forCellReuseIdentifier: "photoCell")
        
        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
        //self.favoritesTableView.isHidden = true
        self.favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "favCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.tweetTableView:
            return 30
        case self.photosTableView:
            return 10
        case self.favoritesTableView:
            return 0
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.tweetTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
            cell.textLabel?.text = "Row \(indexPath.row)"
            return cell
            
        case self.photosTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath)
            cell.textLabel?.text = "Photo \(indexPath.row)"
            return cell
            
        case self.favoritesTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
            cell.textLabel?.text = "Fav \(indexPath.row)"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
