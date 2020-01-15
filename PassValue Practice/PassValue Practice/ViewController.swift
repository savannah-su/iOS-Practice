//
//  ViewController.swift
//  PassValue Practice
//
//  Created by Savannah Su on 2020/1/15.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var newContent = ""
    
    var number = ["2", "3", "4", "5"]
    
    @IBAction func nextPageBtn(_ sender: Any) {
        
        toNextPage()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func toNextPage() {
        
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TextView") as? TextViewController else { return }
        //直接create一個叫nextVC，不是從storyboard去抓畫面，在頁面轉換會黑屏->去storyboard抓畫面
        //let nextVC = TextViewController()
        nextVC.delegate = self
        
        show(nextVC, sender: nil)
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        toNextPage()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return number.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.label.text = number[indexPath.row]
//        cell.delegate = self
        
        //for index in 2 ... 5 {
        //cell[indexPath.row].label.text = "\(index)"
        //}
        return cell
    }
}

extension ViewController: ContentDelegate {
    
    func getContent(text: String) {
        self.newContent = text
        self.number.append(newContent)
        tableView.reloadData()
    }
}
