//
//  SelectPersonViewController.swift
//  MealTime
//
//  Created by Ziong on 6/6/18.
//  Copyright © 2018 Ziong Le. All rights reserved.
//

import UIKit

class SelectPersonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var username: String?
    var profiles = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    private let tableViewCellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getProfiles()
        
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: tableViewCellReuseIdentifier)
        cell.textLabel?.text = profiles[indexPath.row]
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentDishesViewController(profileID: indexPath.row)
    }
    
    // MARK : Helpers
    func getProfiles() {
        
        API.shared.getProfiles { (profs) in
            for profile in profs {
                self.profiles.append(profile[0])
            }
            self.tableView.reloadData()
            self.getProfileIdxSearch()
        }
        
    }
    
    func getProfileIdxSearch() {
        for index in 0..<self.profiles.count {
//            print(profiles[i])
            if (self.profiles[index] == self.username){
                self.presentDishesViewController(profileID: index)
            }
            
        }
    }
    
    func presentDishesViewController (profileID: Int) {
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let dishesPersonViewController = mainStoryBoard.instantiateViewController(withIdentifier: "DishesPersonViewController") as! DishesPersonViewController
        dishesPersonViewController.profile = profileID
        dishesPersonViewController.userName = self.username
        self.present(dishesPersonViewController, animated: true, completion: nil)
    }
    
    
}
