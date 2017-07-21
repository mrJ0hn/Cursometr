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
    @IBOutlet weak var tblView: UITableView!
    
    var activityIndicator : UIActivityIndicatorView!
    var currencies : [Currency] = []
    var indexSelectedCurrency: Int? = nil
    
    enum SegueIdentifier: String {
        case chooseSourceViewController = "ChooseSourceViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
        tblView.tableFooterView = UIView(frame: .zero)
        tblView.tableFooterView?.isHidden = true
        
        activityIndicator = CustomActivityIndicator().get()
        view.addSubview(activityIndicator)
        
        startLoading()
        CurrencyListService.shared.obtainCurrencyList(onSuccess: { (currencies) in
            DispatchQueue.main.async {
                self.currencies = currencies
                self.tblView.reloadData()
                self.stopLoading()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tblView.dequeueReusableCell(withIdentifier: String(describing: QuotationsTableViewCell.self), for: indexPath) as! QuotationsTableViewCell
        cell.setConfig(currency: currencies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelectedCurrency = indexPath.row
        performSegue(withIdentifier: SegueIdentifier.chooseSourceViewController.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier,
            let sid = SegueIdentifier(rawValue: id) else {
                return
        }
        switch sid {
        case .chooseSourceViewController:
            let vc = segue.destination as! ChooseSourceViewController
            vc.currency = currencies[indexSelectedCurrency!]
            vc.delegate = self
        }
    }
    
    func startLoading(){
        view.isUserInteractionEnabled = false
        tblView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopLoading(){
        view.isUserInteractionEnabled = true
        tblView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func currencyChanged(currency: Currency){
        var changedCurrencies = [Subscription]()
        var countSubcribed = 0
        var wasChanged = false
        let prevCurrency = currencies[indexSelectedCurrency!]
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
            CurrencySubscriptionService.shared.changeCurrencySubscription(categoryId: currency.id, subscriptions: changedCurrencies, deleteAll: countSubcribed == 0)
            currencies[indexSelectedCurrency!] = currency
            CurrencyListService.shared.allCurrencies[indexSelectedCurrency!] = currency
            tblView.reloadData()
        }
    }
}
