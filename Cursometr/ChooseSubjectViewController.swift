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
    var selectedItem: FeedbackSubject = .addSource
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView(frame: .zero)
        tblView.tableFooterView?.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedbackSubject.allValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tblView.dequeueReusableCell(withIdentifier: String(describing: FeedbackSubjectTableViewCell.self), for: indexPath) as! FeedbackSubjectTableViewCell
        let subject = FeedbackSubject.allValues[indexPath.row]
        cell.setConfig(title: subject.description, isSelected: subject == self.selectedItem)
        return cell
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = FeedbackSubject.allValues[indexPath.row]
        return indexPath
    }
}
