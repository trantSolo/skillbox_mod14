//
//  DataManager.swift
//  mod13
//
//  Created by Solo Trant on 18/03/2019.
//  Copyright © 2019 Solo Trant. All rights reserved.
//

import Foundation

class DataManager {
    
    let url = URL(string: "https://api.darksky.net/forecast/7bc258ca3a68cfa7a5ec70a69199ea70/55.755826,37.6173?units=si&exclude=flags,minutely,alerts&lang=ru")!
    
    func getWeatherData(_ completion: @escaping (_ weather: Weather?, _ error: String?) -> Void) {
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("🌶 \(error.localizedDescription)")
                completion(nil, error.localizedDescription)
            } else if let data = data {
                let decoder = JSONDecoder()
                let weather = try? decoder.decode(Weather.self, from: data)
                
                completion(weather, nil)
            } else {
                completion(nil, "unknown error")
            }
        }.resume()
    }
}
