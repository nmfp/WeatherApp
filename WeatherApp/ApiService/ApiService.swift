//
//  ApiService.swift
//  WeatherApp
//
//  Created by Nuno Pereira on 16/05/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import Foundation
import Alamofire

struct ApiService {
    
    static let shared = ApiService()
    let baseUrl = "http://query.yahooapis.com/v1/public/yql?q="
    
    func fetchWeatherForCity(city: String, completion: @escaping ([Weather], Error?) -> ()) {
        
        guard let finalUrl = getURL(cityName: city) else { return }
        
        Alamofire.request(finalUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { (resp) in
            if let err = resp.error {
                print("Failed to fetch weather for \(city) ", err)
                completion([], err)
                return
            }
            guard let data = resp.value else { print("nao conseguiu parse");return }
            
            do {
                let queryResult = try JSONDecoder().decode(QueryResult.self, from: data)
                guard let count = queryResult.query?.count else { return }
                
                if count == 0 { completion([], nil) }
                
                guard let weatherArray = queryResult.query?.results?.data else { return }
                completion(weatherArray, nil)
            }
            catch let errParsingResp {
                print("Failed to parse response: ", errParsingResp)
            }
        }
    }
    
    func getURL(cityName: String) -> URL? {
        let woeidQuery = "select woeid from geo.places where text=\"\(cityName)\""
        let weatherQuery = "select * from weather.forecast where woeid in (\(woeidQuery)) and u='c'&format=json"
        guard let finalUrl = weatherQuery.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) else { return nil}
        return URL(string: baseUrl + finalUrl)
    }
}




