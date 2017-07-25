//
//  SetNotificationsViewController.swift
//  Cursometr
//
//  Created by iMacAir on 19.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit



class SetNotificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelExchange: UILabel!
    @IBOutlet weak var labelCurrency: UILabel!
    
    var sections: [Section]!
    var currency: Currency!
    var exchange: Exchange!
    var price: Price!
    var selectedIndexPath : IndexPath!
    
    enum CellType{
        case switchCost
        case changeCost
        case segmentControl
    }
    
    enum SegueIdentifier: String {
        case addPriceViewController = "AddPriceViewController"
    }
    
    struct CellModel{
        let name: String?
        let type: CellType
        var value: Double?
    }
    
    struct Section{
        let name: String
        var cells: [CellModel]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSections()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        labelCurrency.text = "\(currency.name) from \(price.range)"
        labelExchange.text = exchange.name
    }
    
    func initializeSections(){
        let purchaseCells = [
            CellModel(name: "Above \(price.salePriceNow)", type: .switchCost, value: price.salePriceNow),
            CellModel(name: "Below \(price.buyPriceNow)", type: .switchCost, value: price.buyPriceNow)]
        let saleCells = [
            CellModel(name: "Above \(price.salePriceNow)", type: .switchCost, value: price.salePriceNow),
            CellModel(name: "Below \(price.buyPriceNow)", type: .switchCost, value: price.buyPriceNow)]
        sections = [Section(name: "Purchase", cells: purchaseCells),
                    Section(name: "Sale", cells: saleCells),
                    Section(name: "Repeat", cells: [CellModel(name: nil, type: .segmentControl, value: nil)])]
    }
    
    func configure(currency: Currency, exchange: Exchange, price: Price){
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
        let cellModel = sections[indexPath.section].cells[indexPath.row]
        switch cellModel.type {
        case .changeCost:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChangeCostTableViewCell.self), for: indexPath) as! ChangeCostTableViewCell
            cell.configure(cost: cellModel.value!)
            cell.onSelected = {[weak self] (cell) in
                guard let index = self?.tableView.indexPath(for: cell) else { return }
                self?.selectedIndexPath = index
            }
            return cell
        case .switchCost:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SwitchCostTableViewCell.self), for: indexPath) as! SwitchCostTableViewCell
            cell.configure(title: cellModel.name!)
            cell.onStateChange = { [weak self] (cell) in
                guard let index = self?.tableView.indexPath(for: cell) else { return }
                self?.cellCallback(cell: cell, index: index, cellType: .switchCost)
            }
            return cell
        case .segmentControl:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SegmentedControlTableViewCell.self), for: indexPath) as! SegmentedControlTableViewCell
            return cell
        }
    }
    
    func cellCallback(cell : UITableViewCell, index: IndexPath, cellType: CellType){
        switch cellType {
        case .switchCost:
            let cell = cell as! SwitchCostTableViewCell
            let newIndexPath = IndexPath(row: index.row+1, section: index.section)
            if cell.switchState{
                let lastCell = self.sections[index.section].cells[index.row]
                let cell = CellModel(name: String(lastCell.value!),type: .changeCost, value: lastCell.value)
                self.sections[newIndexPath.section].cells.insert(cell, at: newIndexPath.row)
                self.tableView.insertRows(at: [newIndexPath], with: .none)
            }
            else{
                self.sections[newIndexPath.section].cells.remove(at: newIndexPath.row)
                self.tableView.deleteRows(at: [newIndexPath], with: .none)
            }
        case .changeCost:
            break
        default: break
        }
    }
    
    @IBAction func unwindToAddPriceViewController(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? AddPriceViewController {
            if let cost = sourceViewController.cost{
                sections[selectedIndexPath.section].cells[selectedIndexPath.row].value = cost
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
        }
    }
    
    @IBAction func cancelAddPrice(sender: UIStoryboardSegue){}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier,
            let sid = SegueIdentifier(rawValue: id) else {
                return
        }
        switch sid {
        case .addPriceViewController:
            let destinationNavigationController = segue.destination as! UINavigationController
            let vc = destinationNavigationController.topViewController as! AddPriceViewController
            vc.configure(cost: sections[selectedIndexPath.section].cells[selectedIndexPath.row].value!)
        }
    }
}
