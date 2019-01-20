//
//  SelecPersonViewController.swift
//  MealTime
//
//  Copyright © 2018 Ziong Le. All rights reserved.
//

import UIKit

class SelectPersonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func table

}
