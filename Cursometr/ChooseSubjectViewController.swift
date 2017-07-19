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
    let sources = SourcesFeedback.shared.sources
    var selectedItem = SourcesFeedback.Source.addSource
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView(frame: .zero)
        tblView.tableFooterView?.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tblView.dequeueReusableCell(withIdentifier: String(describing: FeedbackSubjectTableViewCell.self), for: indexPath) as! FeedbackSubjectTableViewCell
        cell.setConfig(title: sources[indexPath.row])
        if indexPath.row == selectedItem.rawValue{
            cell.setSelected()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = SourcesFeedback.Source(rawValue: indexPath.row)!
        return indexPath
    }
}
