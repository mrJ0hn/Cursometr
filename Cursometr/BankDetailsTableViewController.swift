//
//  BankDetailsTableViewController.swift
//  Cursometr
//
//  Created by iMacAir on 09.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class BankDetailsTableViewController: UITableViewController {
    @IBOutlet var tblView: UITableView!
    var exchanges : [Exchange] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tblView.refreshControl = refreshControl
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchanges.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankDetailsTableViewCell", for: indexPath) as? BankDetailsTableViewCell
        cell?.setConfig(exchange: exchanges[indexPath.row])
        
        return cell!
    }
    
    func setConfig(exchanges: [Exchange]){
        self.exchanges = exchanges
    }
    
    func refresh(_ refreshControl: UIRefreshControl) {
        // Do your job, when done:
        refreshControl.endRefreshing()
    }
}
