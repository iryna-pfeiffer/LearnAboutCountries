//
//  MapPresenter.swift
//  LearnAboutCountries
//
//  Created by Iryna Pfeiffer on 3/5/19.
//  Copyright © 2019 Iryna Pfeiffer. All rights reserved.
//

import Foundation

class MapPresenter {
    
    private weak var view: MapViewController!
    private var lat: Double = 0
    private var lon: Double = 0
    private var area: Double = 0
    
    init(_ data: CoordinatesAndArea) {
        self.lat = data.latitude
        self.lon = data.longitude
        self.area = data.area
    }
    
    func viewIsLoaded(_ view: MapViewController) {
        self.view = view
        let scaleValue = getScaleValue(for: area)
        view.zoomIntoMap(with: lat, lon: lon, scaleValue: scaleValue)
    }
    
    private     func getScaleValue (for value: Double) -> Int {
        var scaleValue = 0
        switch value {
            case 1...5000:
                scaleValue = 280000
            case 5001...20000:
                scaleValue = 350000
            case 20001...100000:
                scaleValue = 800000
            case 100001...400000:
                scaleValue = 1000000
            case 400001...800000:
                scaleValue = 1300000
            case 800001...1500000:
                scaleValue = 1600000
            case 1500001...6000000:
                scaleValue = 2000000
            case 6000001...9000000:
                scaleValue = 4000000
            default:
                scaleValue = 4500000
        }
        return scaleValue
    }
    
}
