//
//  TableView.swift
//  Cursometr
//
//  Created by iMacAir on 17.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

extension UITableView {
    func register(cellClass: UITableViewCell.Type) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
}
