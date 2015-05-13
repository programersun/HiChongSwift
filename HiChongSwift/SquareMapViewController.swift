//
//  SquareMapViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/6.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit
import MapKit

class SquareMapViewController: UIViewController {
    
    var businessData: SquareMerchantInfoMsg?
    
    @IBOutlet private weak var icyMapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let data = businessData {
            let latitude = data.businessLatitude.bridgeToObjectiveC().doubleValue
            let longitude = data.businessLongitude.bridgeToObjectiveC().doubleValue
            let location = CLLocation(latitude: latitude, longitude: longitude)
            icyMapView.setRegion(MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.018, 0.018)), animated: false)
            
            let business = SquareMapBusiness(location: location, businessName: data.businessName, businessMapNote: data.businessMapNote)
            icyMapView.addAnnotation(business)
            
        } else {
            alert("无法加载商家信息，请后退重试")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SquareMapViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let business = annotation as? SquareMapBusiness {
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as! MKPinAnnotationView!
            if view == nil {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
                view.canShowCallout = true
            } else {
                view.annotation = annotation
            }
            return view
        } else {
            return nil
        }
    }
}

class SquareMapBusiness: NSObject {
    init(location: CLLocation, businessName: String, businessMapNote: String) {
        self.location = location
        self.businessName = businessName
        self.businessMapNote = businessMapNote
    }
    let location: CLLocation
    let businessName: String
    let businessMapNote: String
}

extension SquareMapBusiness: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }
    var title: String {
        return businessName
    }
    var subtitle: String {
        return businessMapNote
    }
}
