//
//  Country.swift
//  LearnAboutCountries
//
//  Created by Iryna Pfeiffer on 2/22/19.
//  Copyright © 2019 Iryna Pfeiffer. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String
}

struct CountryInfo: Decodable {
    let name: String
    let topLevelDomain: [String]?
    let alpha2Code: String?
    let alpha3Code: String?
    let callingCodes: [String]?
    let capital: String?
    let altSpellings: [String]?
    let region: String?
    let subregion: String?
    let population: Double?
    let latlng: [Double]
    let demonym: String?
    let area: Double?
    let timezones: [String]?
    let borders: [String]?
    let nativeName: String?
    let currencies: [Currency]?
    let languages: [Language]?
    let translations: [String : String]?
    let flag: String
 // let gini: Double
//  let numericCode: String
 // let regionalBlocs: [RegionalBlocs]
//  let cioc: String
}

struct Currency: Decodable {
    let code: String
    let name: String
    let symbol: String
}

struct Language: Decodable {
  //  let iso639_1: String
  //  let iso639_2: String
    let name: String
 //   let nativeName: String
}

//struct RegionalBlocs: Decodable {
//   let acronym: String
//    let name: String
//    let otherAcronyms: [String]
//    let otherNames: [String]
//}




