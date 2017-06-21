//
//  2ndView.swift
//  Redcupa_ios
//
//  Created by Alonso Martinez  on 6/1/17.
//  Copyright © 2017 Redcupa. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MyMapsView: UIViewController {
    
    
     override func loadView() {
     
        let camera = GMSCameraPosition.camera(withLatitude: 19.0412967, longitude: -98.20619959999999, zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
     
     
     
     }
     
    
}
