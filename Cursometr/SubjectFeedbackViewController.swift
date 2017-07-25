//
//  ChooseSubjectViewController.swift
//  Cursometr
//
//  Created by iMacAir on 11.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class SubjectFeedbackViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var selectedItem: FeedbackSubject = .addSource
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableFooterView?.isHidden = true
        tableView.selectRow(at: IndexPath(row: FeedbackSubject.allValues.index(of: selectedItem)!, section: 0), animated: true, scrollPosition: .middle)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedbackSubject.allValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SubjectFeedbackTableViewCell.self), for: indexPath) as! SubjectFeedbackTableViewCell
        let subject = FeedbackSubject.allValues[indexPath.row]
        cell.configure(title: subject.description, isSelected: subject == self.selectedItem)
        return cell
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = FeedbackSubject.allValues[indexPath.row]
        return indexPath
    }
}
