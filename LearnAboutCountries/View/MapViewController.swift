//
//  MapViewController.swift
//  LearnAboutCountries
//
//  Created by Iryna Pfeiffer on 2/28/19.
//  Copyright © 2019 Iryna Pfeiffer. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    var presenter: MapPresenter!
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsLoaded(self)
    }
    
    
    func zoomIntoMap (with lat: Double, lon: Double, scaleValue: Int) {
        let coordinates = CLLocationCoordinate2D.init(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: CLLocationDistance(scaleValue), longitudinalMeters: CLLocationDistance(scaleValue))
        mapView.setRegion(region, animated: true)
    }

}
