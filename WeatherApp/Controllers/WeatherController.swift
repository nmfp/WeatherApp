//
//  ViewController.swift
//  WeatherApp
//
//  Created by Nuno Pereira on 16/05/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class WeatherController: UITableViewController, UISearchBarDelegate {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = WeatherController.labelDefaultDescription
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: nil)
        s.searchBar.delegate = self
        s.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        return s
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .gray
        activityIndicator.isHidden = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    var timer: Timer?
    var weatherCities = [Weather]()
    let cellId = "cellId"
    static let labelDefaultDescription = "Search for the weather in your city:"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
        setupTableView()
    }
    
    //MARK:- SetupViews
    fileprivate func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    fileprivate func setupViews() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupTableView() {
        tableView.register(WeatherCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- Helper methods
    func showLoadingAnimation() {
        print("Loading...")
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func hideLoadingAnimation() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func resetTableViewForNewSearch(message: String = labelDefaultDescription) {
        DispatchQueue.main.async{
            self.weatherCities.removeAll()
            self.hideLoadingAnimation()
            self.titleLabel.text = message
            self.tableView.reloadData()
        }
    }
    
    //MARK:- SearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resetTableViewForNewSearch(message: "")
        timer?.invalidate()
        
        if searchText.isEmpty {
            resetTableViewForNewSearch()
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false, block: { (_) in
            self.showLoadingAnimation()
            ApiService.shared.fetchWeatherForCity(city: searchText) { [weak self] (weatherCities, err) in
                if let err = err {
                    print("Failed to fetch data from server: ", err)
                    self?.resetTableViewForNewSearch(message: "Something went wrong with the server. Please try again.")
                    return
                }
                
                if weatherCities.isEmpty {
                    self?.resetTableViewForNewSearch(message: "No cities found.")
                    return
                }
                
                self?.weatherCities = weatherCities
                DispatchQueue.main.async{ self?.tableView.reloadData() }
                self?.searchController.searchBar.resignFirstResponder()
            }
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetTableViewForNewSearch()
    }
}

