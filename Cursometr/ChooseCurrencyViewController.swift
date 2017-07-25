//
//  ChooseSourceViewController.swift
//  Cursometr
//
//  Created by iMacAir on 16.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ChooseCurrencyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var labelCurrency: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: CurrencyChangedDelegate? = nil
    var currency : Currency!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableFooterView?.isHidden = true
        labelCurrency.text = currency.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChooseCurrencyTableViewCell.self), for: indexPath) as! ChooseCurrencyTableViewCell
        cell.configure(exchange:  currency.sources[indexPath.row])
        cell.onStateChange = { [weak self] cell in
            guard let index = self?.tableView.indexPath(for: cell) else { return }
            self?.currency.sources[index.row].subscribed = !((self?.currency!.sources[index.row].subscribed)!)
        }
        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParentViewController {
            delegate?.currencyChanged(currency: currency)
        }
    }
    
    func configure(currency: Currency){
        self.currency = currency
    }
}
