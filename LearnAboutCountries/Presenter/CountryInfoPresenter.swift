//
//  CountryInfoPresenter.swift
//  LearnAboutCountries
//
//  Created by Iryna Pfeiffer on 2/27/19.
//  Copyright © 2019 Iryna Pfeiffer. All rights reserved.
//

import Foundation

class CountryInfoPresenter {

     private var selectedCountry: String
     private weak var view: CountryInfoViewController!
     private let apiDataService = ApiDataService()
     private var detailedInfo: CountryInfo?
     var detailedInfoArray: [(name: String, value: String)] = []
     let formatter = NumberFormatter()
     private var coordAndArea: [Double] = []
     var count: Int {
         return detailedInfoArray.count + 2
     }
    
    init(_ selectedCountry: String) {
        self.selectedCountry = selectedCountry
    }
    
     func viewIsLoaded(_ view: CountryInfoViewController) {
        view.title = selectedCountry
        self.view = view
        loadInfo(for: selectedCountry)
     }

    func loadInfo(for searchParam: String) {
        let delimeter = " "
        var selectedCountryArray = searchParam.components(separatedBy: delimeter)
        let searchWord = String(selectedCountryArray[0].lowercased())
        
        apiDataService.loadCountryInfo(for: searchWord) { [weak self] (countries) in
            for item in countries {
                if item.name == self?.selectedCountry {
                    self?.detailedInfo = item
                }
            }
            
            if let details = self?.detailedInfo {
                self?.saveDataIntoArray(for: details)
            } else {
                print("Not able to retrive Detailed info")
                return
            }
            self?.view?.reload()
         }
     }
    
    func getCellData(at index: Int) -> (String, String) {
        return detailedInfoArray[index - 2]
    }
    

    func setCoordinatesAndArea() {
        coordAndArea.append(detailedInfo?.latlng[0] ?? 48.3794)
        coordAndArea.append(detailedInfo?.latlng[1] ?? 31.1656)
        coordAndArea.append(detailedInfo?.area ?? 15000000)
    }
    
    func showMap() {
        guard let vc = view?.storyboard?.instantiateViewController(withIdentifier: "MapVC") as? MapViewController
            else { return }
        setCoordinatesAndArea()
        let mapPresenter = MapPresenter(latitude: coordAndArea[0], longitude: coordAndArea[1], area: coordAndArea[2])
        vc.presenter = mapPresenter
        view?.showMapViewController(vc: vc)
    }
}



//MARK: - Saving data from Model Structure to an Array
extension CountryInfoPresenter {
    
    func saveDataIntoArray (for data: CountryInfo) {
        appendElement(propertyName: "Native Name", propertyValue: data.nativeName)
        appendElement(propertyName: "Alternative Name Spellings", propertyValue: data.altSpellings)
        appendElement(propertyName: "Capital", propertyValue: data.capital)
        appendElement(propertyName: "Demonym", propertyValue: data.demonym)
        appendElement(propertyName: "Top Level Domain", propertyValue: data.topLevelDomain)
        appendElement(propertyName: "Region", propertyValue: data.region)
        appendElement(propertyName: "Subregion", propertyValue: data.subregion)
        appendElement(propertyName: "Borders", propertyValue: data.borders)
        appendElement(propertyName: "Population", propertyValue: data.population)
        appendElement(propertyName: "Area, sq km", propertyValue: data.area)
        appendElement(propertyName: "2 Digit Country Code", propertyValue: data.alpha2Code)
        appendElement(propertyName: "3 Digit Country Code", propertyValue: data.alpha3Code)
        if let codes = data.callingCodes {
            let codesWithPlusSymbol = codes.map{" +" + $0}
            appendElement(propertyName: "Calling Code", propertyValue: codesWithPlusSymbol)
        }
        appendElement(propertyName: "Time Zone", propertyValue: data.timezones)
        if let currencies = data.currencies {
            let currInfo = currencies.map{$0.name + "\n(" + $0.code + ", " + $0.symbol + ")"}
            appendElement(propertyName: "Currency\n(code, symbol)", propertyValue: currInfo)
        }
        if let languages = data.languages {
            let langNames = languages.map{$0.name}
            appendElement(propertyName: "Language", propertyValue: langNames)
        }
        if let translations = data.translations {
            let transArray = translations.map{$0.key + ":  " + $0.value}
            appendElement(propertyName: "Translations", propertyValue: transArray)
        }
    }
    
    
    func appendElement(propertyName: String, propertyValue: String?) {
        if let data = propertyValue, !data.isEmpty {
            self.detailedInfoArray.append((name: propertyName, value: data))
        } else {
            self.detailedInfoArray.append((name: propertyName, value: "No information available"))
        }
    }
    
    func appendElement(propertyName: String, propertyValue: Double?) {
        if let data = propertyValue {
            let roundedValue = Int(data)
            formatter.numberStyle = NumberFormatter.Style.decimal
            formatter.locale = Locale(identifier: "FR_fr")
            let prettyValue = formatter.string(for: roundedValue)
            self.detailedInfoArray.append((name: propertyName, value: prettyValue ?? "\(roundedValue)"))
        } else {
            self.detailedInfoArray.append((name: propertyName, value: "No information available"))
        }
    }
    
    func appendElement(propertyName: String, propertyValue: [String]?) {
        if let data = propertyValue {
            let string = data.joined(separator: ",\n")
            if !string.isEmpty {
                self.detailedInfoArray.append((name: propertyName, value: string))
            } else {
                self.detailedInfoArray.append((name: "Calling Code", value: "No information available"))
            }
        }
    }
    
}
