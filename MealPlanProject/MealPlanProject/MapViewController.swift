//
//  MapViewController.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 4/15/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var store: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let geoCoder = CLGeocoder();
        let cityName = city.text!
        CLGeocoder().geocodeAddressString(cityName, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    
                    print(location)
                    
                    let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    self.map.setRegion(region, animated: true)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    ani.title = placemark.locality
                    ani.subtitle = placemark.subLocality
                    
                    self.map.addAnnotation(ani)
                    
                    
                }
        })
        // Do any additional setup after loading the view.
    }
    
    @IBAction func search(_ sender: UIButton) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.store.text
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print(response.mapItems)
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 1...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                let ani = MKPointAnnotation()
                ani.coordinate = place.location!.coordinate
                ani.title = place.name
                ani.subtitle = place.subLocality
                
                self.map.addAnnotation(ani)
                
            }
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
