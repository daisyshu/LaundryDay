//
//  InfoViewController.swift
//  Laundry_Home
//
//  Created by Sage Lee on 11/28/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     
    // header section
    var locationLabel: UILabel!
    var infoLabel: UILabel!
    
    // selected machine section
    var machineLabel: UILabel!
    var machineArray: [Machine]!
    var machineCollectionView: UICollectionView!
    
    // timer/picker section
    var pickerLabel: UILabel!
    var timer: Timer?
    var duration: Int?
    let picker = TimePicker()
    var hrArray = ["0","1"]
    let mins = [Int](0...59)
    lazy var minArray = mins.map{ String($0) }
    
    // buttons
    var timeLabel: UILabel!
    var startButton: UIButton!
    var brokenButton: UIButton!
    var emptyAlert: UIAlertController?
    
    // info
    let machineCellReuseIdentifier = "machineCellReuseIdentifier"
    let padding: CGFloat = 15
    var delegate: Timeable?
    var isMine: Bool!
    var indexPath: IndexPath?
    weak var parentVC: HomeViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "laundry day"
        view.backgroundColor = UIColor(red:0.66, green:0.81, blue:0.95, alpha:1.0)
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveInfo))
        navigationItem.rightBarButtonItem = saveButton
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        if let indexPath = self.indexPath {
            if let homeCollectionViewCell = self.parentVC?.mainCollectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell {
                locationLabel.text = homeCollectionViewCell.nameLabel.text
            }
        }
        locationLabel.textColor = .white
        locationLabel.font = UIFont(name: "ArialRoundedMTBold", size: 30)
        view.addSubview(locationLabel)
        
        infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "set a timer for your machine!"
        infoLabel.textColor = .white
        infoLabel.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        view.addSubview(infoLabel)
        
        machineLabel = UILabel()
        machineLabel.translatesAutoresizingMaskIntoConstraints = false
        machineLabel.text = "selected machine:"
        machineLabel.textColor = .white
        machineLabel.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        view.addSubview(machineLabel)
        
        var thisMachine = Machine(name: "machine id", status: .green)
        if let indexPath = self.indexPath {
            if let homeCollectionViewCell = self.parentVC?.mainCollectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell {
                thisMachine = Machine(name: homeCollectionViewCell.nameLabel.text ?? "machine id", status: .green)
            }
        }
        machineArray = [thisMachine]
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        machineCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        machineCollectionView.translatesAutoresizingMaskIntoConstraints = false
        machineCollectionView.backgroundColor = UIColor(red:0.66, green:0.81, blue:0.95, alpha:1.0)
        machineCollectionView.delegate = self
        machineCollectionView.dataSource = self
        machineCollectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: machineCellReuseIdentifier)
        view.addSubview(machineCollectionView)
        
        pickerLabel = UILabel()
        pickerLabel.translatesAutoresizingMaskIntoConstraints = false
        pickerLabel.text = "set timer for in-use:"
        pickerLabel.textColor = .white
        pickerLabel.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        view.addSubview(pickerLabel)
        
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
//        timeLabel.backgroundColor = .white
//        timeLabel.layer.borderWidth = 3
//        timeLabel.layer.borderColor =  UIColor(red: 0.37, green: 0.61, blue: 0.86, alpha: 1.0).cgColor
        timeLabel.text = "00:00:00"
        timeLabel.textColor = .white
        timeLabel.font = UIFont(name: "ArialRoundedMTBold", size: 50)
        timeLabel.isHidden = true
        view.addSubview(timeLabel)
        
        picker.delegate = self
        picker.isHidden = false
        picker.layer.borderWidth = 3
        picker.layer.borderColor = UIColor(red: 0.37, green: 0.61, blue: 0.86, alpha: 1.0).cgColor
        view.addSubview(picker)
        
        startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        startButton.backgroundColor = UIColor(red:0.68, green:0.87, blue:0.67, alpha:1.0)
        startButton.layer.borderWidth = 3
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.setTitle("start cycle!", for: .normal)
        startButton.titleLabel!.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        view.addSubview(startButton)
        
        brokenButton = UIButton()
        brokenButton.translatesAutoresizingMaskIntoConstraints = false
        brokenButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        brokenButton.backgroundColor = UIColor(red:0.95, green:0.74, blue:0.73, alpha:1.0)
        brokenButton.layer.borderWidth = 3
        brokenButton.layer.borderColor = UIColor.white.cgColor
        brokenButton.setTitle("report as broken", for: .normal)
        brokenButton.titleLabel!.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        brokenButton.addTarget(self, action: #selector(brokenChange), for: .touchUpInside)
        view.addSubview(brokenButton)
        
        setupConstraints()
        
        if let duration_temp = duration {
            picker.isHidden = true
            timeLabel.isHidden = false
            self.duration = duration_temp
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.duration! -= 1
                self.timeLabel.text = self.secString(time: TimeInterval(self.duration!))
                if self.duration == 0 {
                    timer.invalidate()
                    self.picker.isHidden = false
                    self.timeLabel.isHidden = true
                }
                
                if let indexPath = self.indexPath {
                    if let homeCollectionViewCell = self.parentVC?.mainCollectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell {
                        homeCollectionViewCell.timeLabel.text = self.secString(time: TimeInterval(self.duration!))
                        homeCollectionViewCell.status.backgroundColor = UIColor(red:1.00, green:0.97, blue:0.73, alpha:1.0)
                        if self.duration == 0 {
                            homeCollectionViewCell.status.backgroundColor = UIColor(red:0.68, green:0.87, blue:0.67, alpha:1.0)
                        }
                        homeCollectionViewCell.durationVal = self.duration
                    }
                }
            }
            machineArray[0].status = .yellow
            machineCollectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let duration_temp = duration {
            picker.isHidden = true
            timeLabel.isHidden = false
            self.duration = duration_temp
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.duration! -= 1
                self.timeLabel.text = self.secString(time: TimeInterval(self.duration!))
                if self.duration == 0 {
                    timer.invalidate()
                    self.picker.isHidden = false
                    self.timeLabel.isHidden = true
                }
                
                if let indexPath = self.indexPath {
                    if let homeCollectionViewCell = self.parentVC?.mainCollectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell {
                        homeCollectionViewCell.timeLabel.text = self.secString(time: TimeInterval(self.duration!))
                        homeCollectionViewCell.status.backgroundColor = UIColor(red:1.00, green:0.97, blue:0.73, alpha:1.0)
                        if self.duration == 0 {
                            homeCollectionViewCell.status.backgroundColor = UIColor(red:0.68, green:0.87, blue:0.67, alpha:1.0)
                        }
                    }
                }
            }
            machineArray[0].status = .yellow
            machineCollectionView.reloadData()
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 7),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            machineLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: padding),
            machineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
//            machineLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            machineCollectionView.topAnchor.constraint(equalTo: machineLabel.bottomAnchor, constant: padding),
            machineCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            machineCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            machineCollectionView.heightAnchor.constraint(equalToConstant: 70)
            ])
        
        NSLayoutConstraint.activate([
            pickerLabel.topAnchor.constraint(equalTo: machineCollectionView.bottomAnchor, constant: padding*2),
            pickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
            ])
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: pickerLabel.bottomAnchor, constant: 80),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: pickerLabel.bottomAnchor, constant: padding),
            picker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: padding*2),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 175),
            startButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        NSLayoutConstraint.activate([
            brokenButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 15),
            brokenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            brokenButton.widthAnchor.constraint(equalToConstant: 175),
            brokenButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return machineArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: machineCellReuseIdentifier, for: indexPath) as! InfoCollectionViewCell
        let machine = machineArray[indexPath.item]
        cell.configure(with: machine)
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 70)
    }
    
    func secString(time:TimeInterval) -> String {
        let hours = Int(time)/3600
        let mins = Int(time)/60%60
        let secs = Int(time)%60
        
        return String(format:"%02i:%02i:%02i", hours, mins, secs)
    }
    
    func postTimerDuration(duration: Int) {
        NetworkManager.postTimerDuration(duration: duration) { (timer) in
            print("timer with \(timer.time_remaining) begun")
        }
    }
    
    @objc func startTimer(sender: UIButton!) {
        
        picker.isHidden = true
        timeLabel.isHidden = false
        
        let hour = picker.selectedRow(inComponent: 0)
        let min = picker.selectedRow(inComponent: 1)
        let sec = picker.selectedRow(inComponent: 2)
        duration = (hour*3600) + (min*60) + (sec)
        
        if duration! > 0 {
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.duration! -= 1
                self.timeLabel.text = self.secString(time: TimeInterval(self.duration!))
                if self.duration == 0 {
                    timer.invalidate()
                    self.picker.isHidden = false
                    self.timeLabel.isHidden = true
                }
                
                if let indexPath = self.indexPath {
                    if let homeCollectionViewCell = self.parentVC?.mainCollectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell {
                        homeCollectionViewCell.timeLabel.text = self.secString(time: TimeInterval(self.duration!))
                        homeCollectionViewCell.status.backgroundColor = UIColor(red:1.00, green:0.97, blue:0.73, alpha:1.0)
                        if self.duration == 0 {
                            homeCollectionViewCell.status.backgroundColor = UIColor(red:0.68, green:0.87, blue:0.67, alpha:1.0)
                        }
                        homeCollectionViewCell.durationVal = self.duration ?? 0
                    }
                }
            }
            postTimerDuration(duration: duration!)
            isMine = true
            machineArray[0].status = .yellow
            machineCollectionView.reloadData()
        } else {
            emptyAlert = UIAlertController(title: "Wait a sec...", message: "Your timer is set to 0.", preferredStyle: .alert)
            emptyAlert?.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(emptyAlert!, animated: true)
            self.picker.isHidden = false
            self.timeLabel.isHidden = true
            isMine = false
        }
    }
    
    @objc func saveInfo(sender: UIBarButtonItem!) {
//        if let delegate = delegate {
//            delegate.startTimer(duration: duration!)
//        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func brokenChange(sender: UIButton!) {
        machineArray[0].status = .red
        if timeLabel.isHidden == false {
//            timer!.invalidate()
            timeLabel.isHidden = true
            picker.isHidden = false
        }
        
        delegate?.reportBroken(set: true)
        machineCollectionView.reloadData()
    }


}
