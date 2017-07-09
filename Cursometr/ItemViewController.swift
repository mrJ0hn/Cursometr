//
//  ItemViewController.swift
//  Cursometr
//
//  Created by iMacAir on 08.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController{

    var itemIndex: Int = 0
    var itemTitle = String()
    
    //@IBOutlet weak var lblTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //lblTitle.text = itemTitle
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setConfig(title: String)
    {
        itemTitle  = title
    }
    
    
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BankDataTableViewCell", for: indexPath) as! BankDataTableViewCell
//        
//        return cell
//    }
}
