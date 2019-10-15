//
//  ViewController.swift
//  membrable places
//
//  Created by mohamed haggag on 8/21/19.
//  Copyright © 2019 mohamed haggag. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class mapview: UIViewController , MKMapViewDelegate ,CLLocationManagerDelegate {
    @IBOutlet weak var map: MKMapView!
    
    var locationmanger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let press = UILongPressGestureRecognizer(target: self, action: #selector(mapview.longpress))
         press.minimumPressDuration = 2
        map.addGestureRecognizer(press)
        
    
if activeplacess == -1
{
locationmanger.delegate = self
    locationmanger.desiredAccuracy=kCLLocationAccuracyBest
    locationmanger.requestWhenInUseAuthorization()
    locationmanger.startUpdatingLocation()
    
    
}
else{
    		if places.count > activeplacess
            {
                if let name = places[activeplacess]["name"]{
                    
                    if let lon = places[activeplacess]["lon"]{
                        if let lat = places[activeplacess]["lat"]
                        {
                            if let latitude  = Double(lat)
                            {
                                if let longitude = Double(lon)
                                {
                                    
                                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    let cordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                    let region = MKCoordinateRegion(center: cordinate, span: span)
                                    map.setRegion(region, animated: true)
                                    
                                    let annotate = MKPointAnnotation()
                                    annotate.title = "tagmahl"
                                    annotate.coordinate=cordinate
                                    map.addAnnotation(annotate)
                                }}}}}}}}

    
    
    @objc func longpress(gesturereco : UIGestureRecognizer){
        
        if gesturereco.state == UIGestureRecognizer.State.began
        {
        
        var title = ""
       let touchpoint = gesturereco.location(in: self.map)
      let cordinate = self.map.convert(touchpoint, toCoordinateFrom: self.map)
            let location = CLLocation(latitude: cordinate.latitude, longitude: cordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                
                if error != nil {

                    print(error!)
                    
                } else{
                    if let placmark = placemarks?[0]{
                
                        if placmark.subThoroughfare != nil {
                            
                            title += placmark.subThoroughfare!

                        }
                        if placmark.subThoroughfare != nil
                        {
                            title += placmark.subThoroughfare!

                        }
                        
                    }}}
            if title == ""
            {
                title += ("\(NSDate())") }
        let anno = MKPointAnnotation()
        anno.coordinate=cordinate
        self.map.addAnnotation(anno)
        anno.title = title
        places.append(["name":"\(title)","lat":"\(cordinate.latitude)","lon":"\(cordinate.longitude)"])
            print(places)
        }}
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let loction = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: loction, span: span)
        map.setRegion(region, animated: true)
    }
    
    
}
