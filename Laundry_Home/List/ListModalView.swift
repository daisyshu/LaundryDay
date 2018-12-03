//
//  ListModalView.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/1/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate: class {
    func saveButtonTapped(item: LaundryList, row: Int)
}

protocol ModalViewControllerDelegate2: class {
    func favoriteButtonTapped(item: LaundryList, row: Int, indexPath: IndexPath)
}

class ListModalView: UIViewController {
    var editItem: UILabel!
    var itemName: UITextField!
    var save: UIButton!
    var favorite: UIButton!
    var item: LaundryList!
    var row: Int!
    var indexPath: IndexPath!
    
    weak var delegate: ModalViewControllerDelegate?
    weak var delegate2: ModalViewControllerDelegate2?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 0.66, green: 0.81, blue: 0.95, alpha: 1.0)
        
        editItem = UILabel()
        editItem.translatesAutoresizingMaskIntoConstraints = false
        editItem.text = "Edit Item:"
        editItem.textColor = .white
        editItem.font = UIFont(name: "ArialRoundedMTBold", size: 18)
        editItem.textAlignment = .left
        view.addSubview(editItem)
        
        itemName = UITextField()
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemName.text = item.item
        itemName.textColor = UIColor.init(red: 0.37, green: 0.61, blue: 0.86, alpha: 1.0)
        itemName.textAlignment = .left
        itemName.font = UIFont(name: "ArialRoundedMTBold", size: 18)
        itemName.borderStyle = .roundedRect
        itemName.backgroundColor = UIColor.init(red: 224/255, green: 228/255, blue: 229/255, alpha: 1.0)
        view.addSubview(itemName)
        
        save = UIButton()
        save.translatesAutoresizingMaskIntoConstraints = false
        save.setTitle("Save", for: .normal)
        save.backgroundColor = UIColor.init(red: 0.66, green: 0.81, blue: 0.95, alpha: 1.0)
        save.setTitleColor(.white, for: .normal)
        save.addTarget(self, action: #selector(dismissViewControllerAndSaveText), for: .touchUpInside)
        view.addSubview(save)
        
        favorite = UIButton()
        favorite.translatesAutoresizingMaskIntoConstraints = false
        favorite.setTitle("Favorite", for: .normal)
        favorite.backgroundColor = UIColor.init(red: 0.66, green: 0.81, blue: 0.95, alpha: 1.0)
        favorite.setTitleColor(.red, for: .normal)
        favorite.addTarget(self, action: #selector(displayImage), for: .touchUpInside)
        view.addSubview(favorite)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        //Edit item label
        NSLayoutConstraint.activate([
            editItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            editItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            editItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            editItem.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        //Item name textfield
        NSLayoutConstraint.activate([
            itemName.topAnchor.constraint(equalTo: editItem.topAnchor),
            itemName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            itemName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            itemName.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        //Save button
        NSLayoutConstraint.activate([
            save.topAnchor.constraint(equalTo: editItem.bottomAnchor, constant: 15),
            save.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            save.heightAnchor.constraint(equalToConstant: 48)
            ])
        
        //Favorite button
        NSLayoutConstraint.activate([
            favorite.topAnchor.constraint(equalTo: editItem.bottomAnchor, constant: 15),
            favorite.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            favorite.heightAnchor.constraint(equalToConstant: 48)
            ])
    }
    
    @objc func dismissViewControllerAndSaveText() {
        if let text = itemName.text, text != "" {
            item.item = text
        }
        delegate?.saveButtonTapped(item: item, row: row)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func displayImage() {
        delegate2?.favoriteButtonTapped(item: item, row: row, indexPath: indexPath)
        dismiss(animated: true, completion: nil)
    }
    
}
