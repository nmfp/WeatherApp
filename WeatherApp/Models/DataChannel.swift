//
//  DataChannel.swift
//  WeatherApp
//
//  Created by Nuno Pereira on 21/05/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import Foundation

struct DataChannel: Decodable {
    var data = [Weather]()
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let weatherArray = try? container.decode([Weather].self, forKey: .data) {
            self.data = weatherArray.filter { $0.item != nil }
        }
        else {
            guard let singleWeather = try? container.decode(Weather.self, forKey: .data) else { return }
            self.data.append(singleWeather)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case data = "channel"
    }
}
