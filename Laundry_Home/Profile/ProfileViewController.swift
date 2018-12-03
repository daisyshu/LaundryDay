//
//  ProfileViewController.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/1/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

protocol ChangeNameDelegate: class {
    func nameChanged(newTitle: String)
}

protocol ChangeLocationDelegate: class {
    func locationChanged(newTitle: String)
}

class ProfileViewController: UIViewController {
    var profileLabel: UILabel!
    var infoLabel: UILabel!
    
    var nameLabel: UILabel!
    var nameButton: UIButton!
    var locationLabel: UILabel!
    var locationButton: UIButton!
    
    var balanceLabel: UILabel!
    var balanceAmt: UITextField!
    var dollarSign: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.66, green: 0.81, blue: 0.95, alpha: 1.0)
        title = "laundry day"
        
        profileLabel = UILabel()
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.text = "profile settings"
        profileLabel.textColor = .white
        profileLabel.font = UIFont(name: "ArialRoundedMTBold", size: 30)
        view.addSubview(profileLabel)
        
        infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "change your personal settings"
        infoLabel.textColor = .white
        infoLabel.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        view.addSubview(infoLabel)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "name"
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        view.addSubview(nameLabel)
        
        nameButton = UIButton()
        nameButton.translatesAutoresizingMaskIntoConstraints = false
        if let nameTyped = UserDefaults.standard.string(forKey: "Name") {
            nameButton.setTitle(nameTyped, for: .normal)
        } else {
            nameButton.setTitle("Your Name", for: .normal)
        }
        nameButton.setTitleColor(.darkGray, for: .normal)
        nameButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        nameButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        nameButton.backgroundColor = .white
        nameButton.layer.borderWidth = 3
        nameButton.layer.borderColor = UIColor(red: 0.37, green: 0.61, blue: 0.86, alpha: 1.0).cgColor
        nameButton.layer.cornerRadius = 15
        nameButton.addTarget(self, action: #selector(presentModalViewController), for: .touchUpInside)
        view.addSubview(nameButton)
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = "location"
        locationLabel.textColor = .white
        locationLabel.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        view.addSubview(locationLabel)
        
        locationButton = UIButton()
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        if let locationPicked = UserDefaults.standard.string(forKey: "Location") {
            locationButton.setTitle(locationPicked, for: .normal)
        } else {
            locationButton.setTitle("Current Location", for: .normal)
        }
        locationButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        locationButton.setTitleColor(.darkGray, for: .normal)
        locationButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        locationButton.backgroundColor = .white
        locationButton.layer.borderWidth = 3
        locationButton.layer.borderColor = UIColor(red: 0.37, green: 0.61, blue: 0.86, alpha: 1.0).cgColor
        locationButton.layer.cornerRadius = 15
        locationButton.addTarget(self, action: #selector(pushNavViewController), for: .touchUpInside)
        view.addSubview(locationButton)
        
        balanceLabel = UILabel()
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.text = "current balance:"
        balanceLabel.textColor = .white
        balanceLabel.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        view.addSubview(balanceLabel)
        
        balanceAmt = UITextField()
        balanceAmt.translatesAutoresizingMaskIntoConstraints = false
        if let amtPicked = UserDefaults.standard.string(forKey: "Balance") {
            balanceAmt.text = amtPicked
        } else {
            balanceAmt.text = "0.00"
        }
        balanceAmt.textColor = .darkGray
        balanceAmt.textAlignment = .center
        balanceAmt.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        balanceAmt.borderStyle = .roundedRect
        balanceAmt.backgroundColor = UIColor.init(red: 224/255, green: 228/255, blue: 229/255, alpha: 1.0)
        view.addSubview(balanceAmt)
        
        dollarSign = UILabel()
        dollarSign.translatesAutoresizingMaskIntoConstraints = false
        dollarSign.text = "$"
        dollarSign.textColor = .darkGray
        dollarSign.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        dollarSign.textAlignment = .center
        view.addSubview(dollarSign)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 7),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 100),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            ])
        
        NSLayoutConstraint.activate([
            nameButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 85),
            nameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameButton.widthAnchor.constraint(equalToConstant: 250),
            nameButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            ])
        
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: nameButton.bottomAnchor, constant: 15),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationButton.widthAnchor.constraint(equalToConstant: 250),
            locationButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        NSLayoutConstraint.activate([
            balanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            balanceLabel.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 50),
            balanceLabel.heightAnchor.constraint(equalToConstant: 25)
            ])
        
        NSLayoutConstraint.activate([
            balanceAmt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            balanceAmt.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 12),
            balanceAmt.heightAnchor.constraint(equalToConstant: 25)
            ])
        
        NSLayoutConstraint.activate([
            dollarSign.leadingAnchor.constraint(equalTo: balanceAmt.leadingAnchor, constant: -13),
            dollarSign.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 12),
            dollarSign.heightAnchor.constraint(equalToConstant: 25)
            ])
    }
    
    @objc func pushNavViewController() {
        let navViewController = LocationNavViewController()
        navViewController.delegate = self
        navigationController?.pushViewController(navViewController, animated: true)
        navViewController.parentVC = self
    }
    
    @objc func presentModalViewController() {
        let modalViewController = NameModalViewController()
        modalViewController.delegate = self
        present(modalViewController, animated: true, completion: nil)
    }
    
}

extension ProfileViewController: ChangeNameDelegate {
    func nameChanged(newTitle: String) {
        nameButton.setTitle(newTitle, for: .normal)
    }
}

extension ProfileViewController: ChangeLocationDelegate {
    func locationChanged(newTitle: String) {
        locationButton.setTitle(newTitle, for: .normal)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        view.endEditing(true)
        UserDefaults.standard.set(textField.text ?? "", forKey: "Balance")
        return true
    }
}
