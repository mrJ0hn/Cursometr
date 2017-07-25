//
//  QuotationsViewController.swift
//  Cursometr
//
//  Created by iMacAir on 14.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

protocol CurrencyChangedDelegate: class {
    func currencyChanged(currency: Currency)
}

class QuotationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CurrencyChangedDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator = ActivityIndicator()
    var currencies : [Currency] = []
    var selectedIndexPath: IndexPath!
    
    enum SegueIdentifier: String {
        case chooseCurrencyViewController = "ChooseCurrencyViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableFooterView?.isHidden = true
        
        self.view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        CurrencyListService.shared.obtainCurrencyList(onSuccess: { [weak self] (currencies) in
            DispatchQueue.main.async {
                self?.currencies = currencies
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
            }, onError: { [weak self] (error) in
                DispatchQueue.main.async {
                    self?.showError(error: error)
                    self?.activityIndicator.stopAnimating()
                }
        })
    }

    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedIndexPath = indexPath
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuotationsTableViewCell.self), for: indexPath) as! QuotationsTableViewCell
        cell.configure(currency: currencies[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier,
            let sid = SegueIdentifier(rawValue: id) else {
                return
        }
        switch sid {
        case .chooseCurrencyViewController:
            let vc = segue.destination as! ChooseCurrencyViewController
            vc.configure(currency: currencies[selectedIndexPath.row])
            vc.delegate = self
        }
    }
    
    func currencyChanged(currency: Currency){
        var changedCurrencies = [Subscription]()
        var countSubcribed = 0
        var wasChanged = false
        let prevCurrency = currencies[selectedIndexPath.row]
        for i in 0..<currency.sources.count{
            if prevCurrency.sources[i].subscribed != currency.sources[i].subscribed{
                changedCurrencies.append((currency.sources[i].id, currency.sources[i].subscribed ? .add : .delete))
                wasChanged = true
            }
            if currency.sources[i].subscribed{
                countSubcribed+=1
            }
        }
        if wasChanged{
            CurrencySubscriptionService.shared.changeCurrencySubscription(categoryId: currency.id, subscriptions: changedCurrencies, deleteAll: countSubcribed == 0, onError: {(error) in
                print(error)
            })
            currencies[selectedIndexPath.row] = currency
            CurrencyListService.shared.allCurrencies[selectedIndexPath.row] = currency
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        }
    }
}
