//
//  ChooseSubjectViewController.swift
//  Cursometr
//
//  Created by iMacAir on 11.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ChooseSubjectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    let sources : [String] = ["Add source", "Add quotation", "Add function", "Another"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tblView.dequeueReusableCell(withIdentifier: "FeedbackSubjectTableViewCell", for: indexPath) as! FeedbackSubjectTableViewCell
        cell.setConfig(title: sources[indexPath.row])
        return cell
    }
    
}
