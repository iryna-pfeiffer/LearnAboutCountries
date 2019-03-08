//
//  PersistentDataService.swift
//  LearnAboutCountries
//
//  Created by Iryna Pfeiffer on 2/27/19.
//  Copyright © 2019 Iryna Pfeiffer. All rights reserved.
//

import Foundation

class PersistentDataService {
    
    private let defaults = UserDefaults.standard
    
    func getRecentSearchesFromUserDefaults() -> [String] {
        let items = defaults.array(forKey: "RecentSearchesArray") as? [String]
        return items ?? []
    }
    
    func updateUserDefaults(with items: [String]) {
        defaults.set(items, forKey: "RecentSearchesArray")
    }
    
}
