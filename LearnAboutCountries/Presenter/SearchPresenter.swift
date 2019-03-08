//
//  SearchPresenter.swift
//  LearnAboutCountries
//
//  Created by Iryna Pfeiffer on 2/27/19.
//  Copyright © 2019 Iryna Pfeiffer. All rights reserved.
//

import Foundation

class SearchPresenter {
    
    private weak var view: SearchViewController?
    private let apiDataService = ApiDataService()
    private let persistentDataService = PersistentDataService()
    private var allCountryNames: [String] = []
    private var searchedCountries: [String] = []
    private var recentSearches: [String] = []
    private var isSearching = false
    var count: Int {
        return isSearching ? searchedCountries.count : recentSearches.count
    }
    
    func viewIsLoaded(_ view: SearchViewController) {
        self.view = view
        recentSearches = persistentDataService.getRecentSearchesFromUserDefaults()

        self.loadData()
    }
    
    private func loadData() {
        apiDataService.loadAll { [weak self] (countries) in
            self?.allCountryNames = countries.map{$0.name}
            self?.view?.reload()
        }
    }
    
    func updateSearchedCountries(with searchedText: String) {
          searchedCountries = allCountryNames.filter({$0.prefix(searchedText.count) == searchedText})
        isSearching = true
        if searchedText == ""  {isSearching = false}
    }
    
    func updateSearchFlag(with value: Bool) {
        isSearching = value
    }
    
    func updateRecentSearches(with lastSearchedItem: String) {
        if recentSearches.contains(lastSearchedItem) {
            recentSearches.remove(at: recentSearches.index(of: lastSearchedItem)!)
        } else if recentSearches.count == 10 {
            recentSearches.removeFirst()
        }
        recentSearches.append(lastSearchedItem)
        persistentDataService.updateUserDefaults(with: recentSearches)
       
        view?.reload()
    }
    
    func getCellText(for index: Int) -> String {
        return isSearching ? searchedCountries[index] : recentSearches[recentSearches.count - 1 - index]
    }
    
    func updateSelectedCountry(for index: Int) -> String {
        return isSearching ? searchedCountries[index] : recentSearches[recentSearches.count - 1 - index]
    }
    
    func showDetailedInfo(at index: Int) {
        guard let vc = view?.storyboard?.instantiateViewController(withIdentifier: "CountryInfoVC") as? CountryInfoViewController
            else { return }
        let selectedCountry = updateSelectedCountry(for: index)
        let countryInfoPresenter = CountryInfoPresenter(selectedCountry)
        vc.presenter = countryInfoPresenter
        view?.showCountryInfoViewController(vc: vc)
        updateRecentSearches(with: selectedCountry)
    }
    

}
