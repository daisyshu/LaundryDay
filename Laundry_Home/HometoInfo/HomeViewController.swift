//
//  HomeViewController.swift
//  Laundry_Home
//
//  Created by Sage Lee on 11/27/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var userLabel: UILabel!
    var filterCollectionView: UICollectionView!
    var infoLabel: UILabel!
    var mainCollectionView: UICollectionView!
    var filtersArray: [Filter]!
    var matArray: [MachineStruct]!
    var yourArray: [MachineStruct]!
    var refreshControl: UIRefreshControl!
    
    let mainCellReuseIdentifier = "mainCellReuseIdentifier"
    let filterCellReuseIdentifier = "filterCellReuseIdentifier"
    let yourCellReuseIdentifier = "yourCellReuseIdentifier"
    let otherCellReuseIdentifier = "otherCellReuseIdentifier"
    let headerSuppReuseIdentifier = "headerSuppReuseIdentifier"
    let padding: CGFloat = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "laundry day"
        view.backgroundColor = UIColor(red:0.66, green:0.81, blue:0.95, alpha:1.0)
        
        userLabel = UILabel()
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.text = "name here"
        userLabel.textColor = .white
        userLabel.font = UIFont(name: "ArialRoundedMTBold", size: 30)
        view.addSubview(userLabel)
        
        let Washers = Filter(filterVal: .washers)
        let Dryers = Filter(filterVal: .dryers)
        filtersArray = [Washers, Dryers]
        
        let filterLayout = UICollectionViewFlowLayout()
        filterLayout.scrollDirection = .horizontal
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.backgroundColor = .white
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        view.addSubview(filterCollectionView)
        
        infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "select an available machine to set its timer!"
        infoLabel.textColor = .white
        infoLabel.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        view.addSubview(infoLabel)
        
        getMachinesFirst()
        
//        let Donlon = TempLaundromat(name: .Donlon)
//        let Court = TempLaundromat(name: .Court)
//        let Rose = TempLaundromat(name: .Rose)
//        matArray = [Donlon, Court, Rose]
//        let Dummy = TempLaundromat(name: .Donlon)
//        yourArray = [Dummy]
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.backgroundColor = UIColor(red:0.66, green:0.81, blue:0.95, alpha:1.0)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.alwaysBounceVertical = true
        mainCollectionView.refreshControl = refreshControl
        mainCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: mainCellReuseIdentifier)
        mainCollectionView.register(HomeCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerSuppReuseIdentifier)
        view.addSubview(mainCollectionView)
        
        setupConstraints()
        
//        createTabBarController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getMachinesSecond()
    }
    
    func getMachinesFirst() {
        if let location = UserDefaults.standard.string(forKey: "Location") {
            let locationId = UserDefaults.standard.integer(forKey: "Location_id")
            print(location)
            print(locationId)
            userLabel.text = location
            
            // network request for this location
            NetworkManager.getMachinesinLocation { machines in
                self.matArray = machines
                self.yourArray = nil
                print(self.matArray)
                DispatchQueue.main.async() {
                    self.mainCollectionView.reloadData()
                }
            }
//            NetworkManager.getLocations { locations in
//                self.locationsList = locations
//                print(locations)
//                DispatchQueue.main.async() {
//                    self.tableView.reloadData()
//                }
//            }
            // { machines in
            // yourArray = machines
            // reload}
        } else {
            userLabel.text = "select a location!"
        }
    }
    
    func getMachinesSecond() {
        if let location = UserDefaults.standard.string(forKey: "Location") {
            let locationId = UserDefaults.standard.integer(forKey: "Location_id")
            print(location)
            print(locationId)
            userLabel.text = location
            
            // network request for this location
            NetworkManager.getMachinesinLocation { machines in
                self.matArray = machines
//                for machine in machines {
//                    if machine.
//                }
                self.yourArray = nil
                print(self.matArray)
                DispatchQueue.main.async() {
                    self.mainCollectionView.reloadData()
                }
            }
            //            NetworkManager.getLocations { locations in
            //                self.locationsList = locations
            //                print(locations)
            //                DispatchQueue.main.async() {
            //                    self.tableView.reloadData()
            //                }
            //            }
            // { machines in
            // yourArray = machines
            // reload}
        } else {
            userLabel.text = "select a location!"
        }
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            userLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 7),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: padding),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: padding),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.mainCollectionView {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mainCollectionView {
            if section == 0 {
                if yourArray != nil {
                    return yourArray.count
                } else {
                    return 0
                }
            } else {
                if matArray != nil {
                    return matArray.count
                } else {
                    return 0
                }
            }
//            return (section == 0) ? yourArray.count : matArray.count
        } else {
            return filtersArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.mainCollectionView {
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainCellReuseIdentifier, for: indexPath) as! HomeCollectionViewCell
                let laundromat = yourArray[indexPath.item]
                cell.configure(with: laundromat)
                cell.setNeedsUpdateConstraints()
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainCellReuseIdentifier, for: indexPath) as! HomeCollectionViewCell
                let laundromat = matArray[indexPath.item]
                cell.configure(with: laundromat)
                cell.setNeedsUpdateConstraints()
                return cell
            }
        } else {
            let cellFilter = filterCollectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            let filter = filtersArray[indexPath.item]
            cellFilter.configure(with: filter)
            cellFilter.setNeedsUpdateConstraints()
            return cellFilter
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.mainCollectionView {
//            let homeCVcell = HomeCollectionViewCell()
            let infoViewController = InfoViewController()
            infoViewController.parentVC = self
            infoViewController.indexPath = indexPath
            let homeCollectionViewCell = mainCollectionView.cellForItem(at: indexPath) as! HomeCollectionViewCell
            let workingDur = homeCollectionViewCell.durationVal
            infoViewController.duration = workingDur
            
//            yourArray.append(matArray[indexPath.item])
            
//            // convert duration into seconds
//            let cell = collectionView.cellForItem(at: indexPath) as! HomeCollectionViewCell
//            let durStr = cell.timeLabel.text ?? "00:00:00"
//            // getting hours
//            let hrs = Int(durStr.prefix(2)) ?? 0
//            // getting minutes
//            let start = durStr.index((durStr.startIndex), offsetBy: 4)
//            let end = durStr.index((durStr.endIndex), offsetBy: -3)
//            let range = start..<end
//            let mins = Int(durStr[range]) ?? 0
//            // getting seconds
//            let secs = Int(durStr.suffix(2)) ?? 0
//            // calculating duration
//            let workingDur = (hrs*3600)+(mins*60)+(secs)
            
            navigationController?.pushViewController(infoViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.mainCollectionView {
            return CGSize(width: 350, height: 70)
        } else {
            let width = UIScreen.main.bounds.width
            return CGSize(width: width/2, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerSuppReuseIdentifier, for: indexPath) as! HomeCollectionReusableView
        if indexPath.section == 0 {
            if kind == UICollectionView.elementKindSectionHeader {
                headerView.headerLabel.text = "your current machines:"
            }
        } else {
            if kind == UICollectionView.elementKindSectionHeader {
                headerView.headerLabel.text = "other machines:"
            }
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == mainCollectionView {
            return CGSize(width: 200, height: 50)
        } else {
            return .zero
        }
    }
    
    @objc func pullToRefresh() {
        print("pulled")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl.endRefreshing()
        }
    }

}


