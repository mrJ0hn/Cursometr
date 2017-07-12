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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "BankDetailsTableViewHeaderCell") as! BankDetailsTableViewHeaderCell
        headerCell.setConfig(title: exchanges[section].name)
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
        cell?.setConfig(price: exchanges[indexPath.section].prices[indexPath.row])
        if indexPath.row == 0{
            if indexPath.row == exchanges[indexPath.section].prices.count-1 {
                cell!.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)}
                else{
                    cell!.roundCorners([.topLeft, .topRight], radius: 10)
                }
            
        }
        else if indexPath.row == exchanges[indexPath.section].prices.count-1 {
            cell!.roundCorners([.bottomLeft, .bottomRight], radius: 10)
        }
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
