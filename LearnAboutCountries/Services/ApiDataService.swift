//
//  ApiDataService.swift
//  LearnAboutCountries
//
//  Created by Iryna Pfeiffer on 2/22/19.
//  Copyright © 2019 Iryna Pfeiffer. All rights reserved.
//

import Foundation

class ApiDataService {
    
    func loadAll(completion: @escaping ([Country])->()) {
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all?fields=name") else { completion([]); return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            guard let data = data else { completion([]); return }
            let decoder = JSONDecoder()
            let list = try? decoder.decode([Country].self, from: data)
            completion(list ?? [])
        }.resume()
    }
    

    func loadCountryInfo(for country: String, completion: @escaping ([CountryInfo])->()) {
        guard let url = URL(string: "https://restcountries.eu/rest/v2/name/" + country) else {completion([]); return }
        URLSession.shared.dataTask(with: url) {(data,response, error) in
       //     print("JSON String: \(String(describing: String(data: data!, encoding: .utf8)))")
            do{
                let country = try JSONDecoder().decode([CountryInfo].self, from: data!)
       //        print("COUNT IS \(country.count)")
                //error.localizedDescription
                completion(country)
            
            } catch {
                completion([])
                return
            }
        }.resume()
     }

}
