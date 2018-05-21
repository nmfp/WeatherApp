//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Nuno Pereira on 18/05/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    
    lazy var cityLabel = getLabel(textAlignment: .left)
    lazy var countryStateLabel = getLabel(textAlignment: .left)
    lazy var conditionLabel = getLabel(textAlignment: .right)
    lazy var temperatureLabel = getLabel(textAlignment: .right)
    
    var weatherCity: Weather? {
        didSet {
            cityLabel.text = weatherCity?.location?.city
            countryStateLabel.text = "\(weatherCity?.location?.country ?? "") - \(weatherCity?.location?.region ?? "")"
            conditionLabel.text = weatherCity?.item?.condition?.text
            temperatureLabel.text = weatherCity?.item?.condition?.temp
        }
    }
    
    func setupViews() {
        addSubview(cityLabel)
        addSubview(countryStateLabel)
        addSubview(conditionLabel)
        addSubview(temperatureLabel)
        cityLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: (frame.width / 2) - 8, height: 40)
        countryStateLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: (frame.width / 2) - 8, height: 40)
        conditionLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: (frame.width / 2) - 8, height: 40)
        temperatureLabel.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: (frame.width / 2) - 8, height: 40)
    }
    
    func getLabel(textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
