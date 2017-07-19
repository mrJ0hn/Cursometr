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
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tblView.refreshControl = refreshControl
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let  headerCell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "BankDetailsTableViewHeaderCell") as! BankDetailsTableViewHeaderCell
        headerCell.set(title: exchanges[section].name)
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return exchanges.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchanges[section].prices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankDetailsTableViewCell", for: indexPath) as? BankDetailsTableViewCell
        let exchange = exchanges[indexPath.section]
        cell?.setConfig(price: exchange.prices[indexPath.row], showSellPrice: exchange.showSellPrice)
        cell?.setUIConfig(row: indexPath.row, count: exchanges[indexPath.section].prices.count)
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
