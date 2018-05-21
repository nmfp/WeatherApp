//
//  LogoViewController.swift
//  WeatherApp
//
//  Created by Nuno Pereira on 20/05/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import Foundation
import UIKit

class LogoViewController: UIViewController {
    
    let appLabel: UILabel = {
        let label = UILabel()
        label.text = "WeatherApp"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func setupAppLabel() {
        view.addSubview(appLabel)
        appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAppLabel()
    }
}
