//
//  ViewController.swift
//  PassValue Practice
//
//  Created by Savannah Su on 2020/1/15.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var index: Int?
    var newContent = ""
    
    var content = ["2", "3", "4", "5"]
    
    @IBAction func nextPageBtn(_ sender: Any) {
        
        toNextPage(index: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func toNextPage(text: String = "", index: Int?) {
        
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TextView") as? TextViewController else { return }
        //直接create一個叫nextVC，不是從storyboard去抓畫面，在頁面轉換會黑屏->去storyboard抓畫面
        //let nextVC = TextViewController()
        nextVC.textField.text = text
        nextVC.index = index
        //跟要資料VC有關連的地方叫出delegate
        nextVC.delegate = self
        
        show(nextVC, sender: nil)
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        toNextPage(text: content[indexPath.row], index: indexPath.row)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.label.text = content[indexPath.row]
        //target Action
        //(1)cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteContent(sender:)), for: .touchUpInside)
        
        return cell
    }
    //target Action
    @objc func deleteContent(sender: UIButton) {
        //btn的superview的superview是cell，去拿到indexPath
        guard let cell = sender.superview?.superview as? TableViewCell, let indexPath = tableView.indexPath(for: cell) else { return }
        //先去array裡面刪掉資料
        content.remove(at: indexPath.row)
        //此func包含reload TabelView
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
}

extension ViewController: ContentDelegate {
    
    func updateContent(text: String, index: Int) {
        self.content[index] = text
        tableView.reloadData()
    }
    
    
    func createNewContent(text: String) {
        self.newContent = text
        self.content.append(newContent)
        tableView.reloadData()
    }
}
