//
//  NameModalViewController.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/1/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class NameModalViewController: UIViewController {
    var changeLabel: UILabel!
    
    var enterNameLabel: UILabel!
    var yourName: UITextField!
    var save: UIButton!
    
    weak var delegate: ChangeNameDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 0.66, green: 0.81, blue: 0.95, alpha: 1.0)
        
        changeLabel = UILabel()
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLabel.text = "update name"
        changeLabel.textColor = .white
        changeLabel.font = UIFont(name: "ArialRoundedMTBold", size: 30)
        view.addSubview(changeLabel)
        
        enterNameLabel = UILabel()
        enterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        enterNameLabel.text = "enter name:"
        enterNameLabel.textColor = .white
        enterNameLabel.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        enterNameLabel.textAlignment = .left
        view.addSubview(enterNameLabel)
        
        yourName = UITextField()
        yourName.translatesAutoresizingMaskIntoConstraints = false
        yourName.text = ""
        yourName.textAlignment = .left
        yourName.textColor = UIColor.init(red:0.37, green:0.61, blue:0.86, alpha:1.0)
        yourName.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        yourName.borderStyle = .roundedRect
        yourName.backgroundColor = UIColor.init(red: 224/255, green: 228/255, blue: 229/255, alpha: 1.0)
        view.addSubview(yourName)
        
        save = UIButton()
        save.translatesAutoresizingMaskIntoConstraints = false
        save.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        save.backgroundColor = UIColor(red: 0.37, green: 0.61, blue: 0.86, alpha: 1.0)
        save.layer.borderWidth = 3
        save.layer.borderColor = UIColor.white.cgColor
        save.setTitle("save", for: .normal)
        save.setTitleColor(.white, for: .normal)
        save.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        save.addTarget(self, action: #selector(dismissViewControllerAndSaveText), for: .touchUpInside)
        view.addSubview(save)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            changeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            changeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        //Enter name label
        NSLayoutConstraint.activate([
            enterNameLabel.topAnchor.constraint(equalTo: changeLabel.topAnchor, constant: 100),
            enterNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            enterNameLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        //Your name textfield
        NSLayoutConstraint.activate([
            yourName.topAnchor.constraint(equalTo: changeLabel.topAnchor, constant: 100),
            yourName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            yourName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            yourName.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        //Save button
        NSLayoutConstraint.activate([
            save.topAnchor.constraint(equalTo: yourName.bottomAnchor, constant: 30),
            save.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            save.widthAnchor.constraint(equalToConstant: 100),
            save.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    @objc func dismissViewControllerAndSaveText() {
        if let text = yourName.text, text != "" {
            delegate?.nameChanged(newTitle: text)
        }
        UserDefaults.standard.set(yourName.text, forKey: "Name")
        dismiss(animated: true, completion: nil)
    }
    
}

