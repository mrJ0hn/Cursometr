//
//  ChooseSourceViewController.swift
//  Cursometr
//
//  Created by iMacAir on 16.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ChooseSourceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblCurrencyName: UILabel!
    
    weak var delegate: CurrencyChangedDelegate? = nil
    var currency : Currency? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
        tblView.tableFooterView = UIView(frame: .zero)
        tblView.tableFooterView?.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency!.sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tblView.dequeueReusableCell(withIdentifier: "ChooseSourceTableViewCell", for: indexPath) as! ChooseSourceTableViewCell
        cell.setConfig(exchange:  currency!.sources[indexPath.row])
        cell.callback = { [weak self] cell in
            guard let index = self?.tblView.indexPath(for: cell) else { return }
            self?.currency!.sources[index.row].subscribed = !((self?.currency!.sources[index.row].subscribed)!)
        }
        return cell
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if (!(parent?.isEqual(self.parent) ?? false)) {
            if delegate != nil{
                delegate?.currencyChanged(currency: currency!)
            }
        }
    }

}
