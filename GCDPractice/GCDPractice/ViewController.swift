//
//  ViewController.swift
//  GCDPractice
//
//  Created by Savannah Su on 2020/1/14.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

enum Offset {
    
    case zeroOffset
    
    case tenOffset
    
    case twentyOffset
}

class ViewController: UIViewController {
    
    //    struct trafficData {
    //        var roadData = ["", "", ""]
    //        var speedData = ["", "", ""]
    //    }
    
    //zip
    var roadData = ["", "", ""]
    var speedData = ["", "", ""]
    
    let manager = speedDataManager()
    //collection Label
    @IBOutlet var roadLabel: [UILabel]!
    @IBOutlet var speedLabel: [UILabel]!
    @IBAction func groupButton(_ sender: Any) {
        groupAction()
    }
    @IBAction func semaphoreButton(_ sender: Any) {
        semaphoreAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //資料全部一起顯現
    func groupAction() {
        
        cleanLabel()
        
        let group = DispatchGroup()
        
        for index in 0...2 {
            group.enter()
            manager.getSpeedData(index: index, completion: { [weak self] data in
                self?.roadData[index] = data.result.results[0].road
                self?.speedData[index] = data.result.results[0].speedLimit
                group.leave()
            })
        }
        
        //畫面UI要在main queue
        group.notify(queue: .main) { [weak self] in
            
            guard let self = self else { return }
            //roadData跟speedData個數要一樣
            for (label, data) in zip(self.roadLabel, self.roadData) {
                label.text = data
            }
            
            for (label, data) in zip(self.speedLabel, self.speedData) {
                label.text = data
            }
            
        }
    }
    
    func semaphoreAction() {
        
        cleanLabel()
        
        let firstSemaphore = DispatchSemaphore(value: 0)
        let secondSemaphore = DispatchSemaphore(value: 0)
        
        manager.getSpeedData(index: 0, completion: { [weak self] data in
            
            guard let self = self else { return }
            
            self.roadData[0] = data.result.results[0].road
            self.speedData[0] = data.result.results[0].speedLimit
            
            print("Got zeroOffset Data")
            
            DispatchQueue.main.async {
                self.roadLabel[0].text = self.roadData[0]
                self.speedLabel[0].text = self.speedData[0]
                firstSemaphore.signal()
                
                print("Updated zeroOffset UI")
            }
        })
        
        manager.getSpeedData(index: 1, completion: { [weak self] data in
            
            guard let self = self else { return }
            
            self.roadData[1] = data.result.results[0].road
            self.speedData[1] = data.result.results[0].speedLimit
            
            print("Got tenOffset Data")
            
            firstSemaphore.wait()
            DispatchQueue.main.async {
                self.roadLabel[1].text = self.roadData[1]
                self.speedLabel[1].text = self.speedData[1]
                secondSemaphore.signal()
                
                print("Updated tenOffset UI")
            }
        
        })
        manager.getSpeedData(index: 2, completion: { [weak self] data in
            
            guard let self = self else { return }
            
            self.roadData[2] = data.result.results[0].road
            self.speedData[2] = data.result.results[0].speedLimit
            
            print("Got twentyOffset Data")
            
            secondSemaphore.wait()
            DispatchQueue.main.async {
                self.roadLabel[2].text = self.roadData[2]
                self.speedLabel[2].text = self.speedData[2]
                
                print("Updated tewntyOffset UI")
            }
            
        })
        
    }
    
    func cleanLabel() {
        //用removeAll()是整個array清空
        roadLabel.forEach { (label) in
            label.text = ""
        }
        speedLabel.forEach { (label) in
            label.text = ""
        }
    }
    
}

