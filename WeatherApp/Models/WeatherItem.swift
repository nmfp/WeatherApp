//
//  WeatherItem.swift
//  WeatherApp
//
//  Created by Nuno Pereira on 21/05/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import Foundation


struct WeatherItem: Decodable {
    var condition: WeatherStatus?
}
