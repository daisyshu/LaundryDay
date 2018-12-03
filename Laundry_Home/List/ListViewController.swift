//
//  ListViewController.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/1/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableLabel: UILabel!
    var infoLabel: UILabel!
    
    var tableView: UITableView!
    var items: [LaundryList]!
    
    let reuseIdentifier = "listCellReuse"
    let cellHeight: CGFloat = 45
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "laundry day"
        view.backgroundColor = UIColor(red: 0.66, green: 0.81, blue: 0.95, alpha: 1.0)
        
        tableLabel = UILabel()
        tableLabel.translatesAutoresizingMaskIntoConstraints = false
        tableLabel.text = "list"
        tableLabel.textColor = .white
        tableLabel.font = UIFont(name: "ArialRoundedMTBold", size: 30)
        view.addSubview(tableLabel)
        
        infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "what do you need to wash today?"
        infoLabel.textColor = .white
        infoLabel.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        view.addSubview(infoLabel)
        
        let towels = LaundryList(item: "Two towels")
        let sheets = LaundryList(item: "Bed sheets")
        let sweater = LaundryList(item: "Pink sweater")
        let a = LaundryList(item: "")
        let b = LaundryList(item: "")
        let c = LaundryList(item: "")
        let d = LaundryList(item: "")
        let e = LaundryList(item: "")
        let f = LaundryList(item: "")
        let g = LaundryList(item: "")
        let h = LaundryList(item: "")
        let i = LaundryList(item: "")
        let j = LaundryList(item: "")
        let k = LaundryList(item: "")
        let l = LaundryList(item: "")
        let m = LaundryList(item: "")
        let n = LaundryList(item: "")
        
        items = [towels, sheets, sweater, a, b, c, d, e, f, g, h, i, j, k, l, m, n]
        
        // Initialize tableView
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.layer.borderWidth = 3
        tableView.layer.borderColor = UIColor(red: 0.37, green: 0.61, blue: 0.86, alpha: 1.0).cgColor
        tableView.layer.cornerRadius = 15
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // Setup the constraints for our views
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
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ])
    }
    
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ListViewCell
        let item = items[indexPath.row]
        cell.configure(for: item)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = "Don't Forget!"
//        label.textColor = .white
//        label.textAlignment = .center
//        label.backgroundColor = UIColor.init(red: 0.66, green: 0.81, blue: 0.95, alpha: 1.0)
//        return label
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath) as! SongPlaylistViewCell
        let playlist = items[indexPath.row]
        playlist.isFavorite = !playlist.isFavorite
        let listModalView = ListModalView()
        listModalView.item = items[indexPath.row]
        listModalView.row = indexPath.row
        listModalView.indexPath = indexPath
        listModalView.delegate = self
        listModalView.delegate2 = self
        present(listModalView, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            self.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ListViewController: ModalViewControllerDelegate {
    func saveButtonTapped(item: LaundryList, row: Int) {
        items[row] = item
        tableView.reloadData()
    }
}

extension ListViewController: ModalViewControllerDelegate2 {
    func favoriteButtonTapped(item: LaundryList, row: Int, indexPath: IndexPath) {
        items[row] = item
        let cell = tableView.cellForRow(at: indexPath) as! ListViewCell
        cell.toggleHeart(for: items[row])
        tableView.reloadData()
    }
}

