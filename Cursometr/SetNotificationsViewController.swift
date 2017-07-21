//
//  SetNotificationsViewController.swift
//  Cursometr
//
//  Created by iMacAir on 19.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit



class SetNotificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    typealias Section = (name: String, cells: [CellType])
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblExchange: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    
    var sections: [Section]!
    var currency: Currency!
    var exchange: Exchange!
    var price: Price!
    
    enum CellType{
        case switchCost
        case changeCost
        case segmentControl
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sections = [(name: "Purchase", cells: [.switchCost, .switchCost]),
                    (name: "Sale", cells: [.switchCost, .switchCost]),
                    (name: "Repeat", cells: [.segmentControl])]
        tableView.dataSource = self
        tableView.delegate = self
        
        lblCurrency.text = "\(currency.name) from \(price.range)"
        lblExchange.text = exchange.name
    }
    
    func setConfig(currency: Currency, exchange: Exchange, price: Price){
        self.currency = currency
        self.exchange = exchange
        self.price = price
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  header = SetNotificationsTableViewHeader()
        header.set(title: sections[section].name)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        switch sections[indexPath.section].cells[indexPath.row] {
        case .changeCost:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChangeCostTableViewCell.self), for: indexPath) as! ChangeCostTableViewCell
            switch indexPath.row {
            case 0:
                cell.set(cost: price.salePriceNow)
            case 1:
                cell.set(cost: price.buyPriceNow)
            default: break
            }
            return cell
        case .switchCost:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SwitchCostTableViewCell.self), for: indexPath) as! SwitchCostTableViewCell
            if indexPath.row == 0{
                cell.set(title: "Above \(price.salePriceNow)")
                cell.callback = { [weak self] (cell, state) in
                    guard let index = self?.tableView.indexPath(for: cell) else { return }
                    let newIndexPath = IndexPath(row: index.row+1, section: index.section)
                    self?.cellCallback(newIndexPath: newIndexPath, state: state)
                }
            }
            if indexPath.row == 1{
                cell.set(title: "Below \(price.buyPriceNow)")
                cell.callback = { [weak self] (cell, state) in
                    guard let index = self?.tableView.indexPath(for: cell) else { return }
                    let newIndexPath = IndexPath(row: index.row+1, section: index.section)
                    self?.cellCallback(newIndexPath: newIndexPath, state: state)
                }
            }
            return cell
        case .segmentControl:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SegmentControlTableViewCell.self), for: indexPath) as! SegmentControlTableViewCell
            return cell
        }
    }
    
    func cellCallback(newIndexPath: IndexPath, state: Bool){
        if state{
            self.sections[newIndexPath.section].cells.insert(.changeCost , at: newIndexPath.row)
            self.tableView.insertRows(at: [newIndexPath], with: .none)
        }
        else{
            self.sections[newIndexPath.section].cells.remove(at: newIndexPath.row)
            self.tableView.deleteRows(at: [newIndexPath], with: .none)
        }
    }
    
    @IBAction func unwindToAddPriceViewController(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? AddPriceViewController {
            
        }
    }
    @IBAction func cancelAddPrice(sender: UIStoryboardSegue){
    }
    
}
