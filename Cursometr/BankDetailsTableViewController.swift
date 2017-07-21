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
    var currency : Currency!
    var selectedExchange : Exchange?
    var selectedPrice : Price?
    
    enum SegueIdentifier: String {
        case setNotificationsViewController = "SetNotificationsViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tblView.refreshControl = refreshControl
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: String(describing: BankDetailsTableViewHeaderCell.self)) as! BankDetailsTableViewHeaderCell
        headerCell.set(title: exchanges[section].name)
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return exchanges.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchanges[section].prices.count
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedExchange = exchanges[indexPath.section]
        self.selectedPrice = exchanges[indexPath.section].prices[indexPath.row]
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BankDetailsTableViewCell.self), for: indexPath) as? BankDetailsTableViewCell
        let exchange = exchanges[indexPath.section]
        cell?.setConfig(price: exchange.prices[indexPath.row], showSellPrice: exchange.showSellPrice)
        cell?.setUIConfig(row: indexPath.row, count: exchanges[indexPath.section].prices.count)
        return cell!
    }
    
    func setConfig(currency: Currency, exchanges: [Exchange]){
        self.currency = currency
        self.exchanges = exchanges
    }
    
    func refresh(_ refreshControl: UIRefreshControl) {
        // Do your job, when done:
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier,
            let sid = SegueIdentifier(rawValue: id) else {
                return
        }
        switch sid {
        case .setNotificationsViewController:
            let vc = segue.destination as! SetNotificationsViewController
            if let exchange = selectedExchange, let currency = self.currency, let price = self.selectedPrice {
                vc.setConfig(currency: currency, exchange: exchange, price: price)
            }
        }
    }
}
