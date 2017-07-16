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
        BankDataDownloadService.shared.getCurrencyList(onSuccess: { (currencies) in
            DispatchQueue.main.async {
                self.currencies = currencies
                self.tblView.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tblView.dequeueReusableCell(withIdentifier: "QuotationsTableViewCell", for: indexPath) as! QuotationsTableViewCell
        cell.setConfig(currency: currencies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelectedCurrency = indexPath.row
        performSegue(withIdentifier: SegueIdentifier.chooseSourceViewController.rawValue, sender: self)
    }
    
    @IBAction func unwindToLeaveFeedbackViewController(sender: UIStoryboardSegue) {
        if let chooseSourceViewController = sender.source as? ChooseSourceViewController {
            currencies[indexSelectedCurrency!] = chooseSourceViewController.currency!
        }
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
    
    func currencyChanged(currency: Currency){
        currencies[indexSelectedCurrency!] = currency
        tblView.reloadData()
    }
}
