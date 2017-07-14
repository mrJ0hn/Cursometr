//
//  QuotationsViewController.swift
//  Cursometr
//
//  Created by iMacAir on 14.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class QuotationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tblView: UITableView!
    var currencies : [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
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
    
    //    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    //        selectedItem = currencies[indexPath.row]
    //        return indexPath
    //    }
    
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 0
    //    }
}
