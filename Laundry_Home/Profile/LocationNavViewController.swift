//
//  LocationNavViewController.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/1/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class LocationNavViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableLabel: UILabel!
    var infoLabel: UILabel!
    
    var save: UIBarButtonItem!
    var locations: [LocationsList]!
    var locationsList: [Location] =  []
    var tableView: UITableView!
    
    let reuseIdentifier = "locationTableCellReuse"
    let cellHeight: CGFloat = 70
    
    weak var delegate: ChangeLocationDelegate?
    weak var parentVC: ProfileViewController?
    var locID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.66, green: 0.81, blue: 0.95, alpha: 1.0)
        title = "Locations"
        
        tableLabel = UILabel()
        tableLabel.translatesAutoresizingMaskIntoConstraints = false
        tableLabel.text = "change location"
        tableLabel.textColor = .white
        tableLabel.font = UIFont(name: "ArialRoundedMTBold", size: 30)
        view.addSubview(tableLabel)
        
        infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "did ya move?"
        infoLabel.textColor = .white
        infoLabel.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        view.addSubview(infoLabel)
        
//        let aa = LocationsList(location: "Donlon")
//        let a = LocationsList(location: "CKB")
//        let b = LocationsList(location: "Mews")
//        let c = LocationsList(location: "Dickson")
//        let d = LocationsList(location: "Jameson")
//        let e = LocationsList(location: "High Rise 5")
//        let f = LocationsList(location: "Low Rises")
//        let g = LocationsList(location: "North Balch")
//        let gg = LocationsList(location: "South Balch")
//        let h = LocationsList(location: "Townhouses")
//        let i = LocationsList(location: "West")
//        let j = LocationsList(location: "Collegetown")
//
//        locations = [aa, a, b, c, d, e, f, g, gg, h, i, j]
        
        // Initialize tableView
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.layer.borderWidth = 3
        tableView.layer.borderColor = UIColor(red: 0.37, green: 0.61, blue: 0.86, alpha: 1.0).cgColor
        tableView.layer.cornerRadius = 15
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = true
        tableView.register(LocationsViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        getLocations()
        setupConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            tableLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: tableLabel.bottomAnchor, constant: 7),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
    }
    
    func getLocations() {
        NetworkManager.getLocations { locations in
            self.locationsList = locations
            print(locations)
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocationsViewCell
        let location = locationsList[indexPath.row]
//        cell.configure(for: location)
        cell.textLabel?.text = location.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = UIColor.init(red:0.37, green:0.61, blue:0.86, alpha:1.0)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsList.count
    }
    
    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locationsList[indexPath.row]
        parentVC?.locationButton.setTitle(location.name, for: .normal)
        locID = location.id
        UserDefaults.standard.set(locID, forKey: "Location_id")
        UserDefaults.standard.set(location.name, forKey: "Location")
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
