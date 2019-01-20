//
//  DishesPersonViewController.swift
//  MealTime
//
//  Created by Ziong on 09.06.2018.
//  Copyright © 2018 Ziong Le. All rights reserved.
//

import UIKit
import GoogleSignIn

class DishesPersonViewController: UIViewController, GIDSignInUIDelegate {
    var userName: String!
    
    var profile : Int = 0
    var allDishes : [String]! = []
    var profileDishes : [String]! = []
    var profileDishesNum : [Int]! = []
    
    @IBOutlet weak var saladLabel: UILabel!
    @IBOutlet weak var soupLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var garnishLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBAction func signOutButtonPressed(_ sender: Any) {
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let loginViewController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        // Finds user to display his menu
        GIDSignIn.sharedInstance().signOut()
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    
    
    
    override func loadView() {
        super.loadView()
        
        self.saladLabel.backgroundColor = UIColor(red:0.85, green:0.92, blue:0.83, alpha:1.0)
        self.soupLabel.backgroundColor = UIColor(red:1.00, green:0.95, blue:0.80, alpha:1.0)
        self.mainLabel.backgroundColor = UIColor(red:0.99, green:0.90, blue:0.80, alpha:1.0)
        self.garnishLabel.backgroundColor = UIColor(red:0.96, green:0.80, blue:0.80, alpha:1.0)
        self.userLabel.text = "Приятного аппетита \(userName!)"
    }
    
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Dishes
        API.shared.getDishes { (dishes) in
            for dish in dishes[0] {
                self.allDishes.append(dish)
            }
            // Get Profile Dishes
            API.shared.getProfileDishes(profileIndex: self.profile) { (profileDishes) in
                
                for index in 0..<12 {
                    if(index >= profileDishes[0].count || profileDishes[0][index].isEmpty) {
                        self.profileDishesNum.append(0)
                    } else {
                        self.profileDishesNum.append(1)
                    }
                }
                
                for index in 0..<self.allDishes.count {
                    if (self.profileDishesNum[index] == 1) {
                        self.profileDishes.append(self.allDishes[index])
                    } else {
                        self.profileDishes.append("")
                    }
                }
                
                self.setDishesToLabel(dishes: self.profileDishes)
            }
        }

    }
    
    func setDishesToLabel(dishes : [String]) {
        for index in 0..<dishes.count {
            let dish = dishes[index]
            if (dish.isEmpty) {
                continue
            }
            
            if (index >= 0 && index <= 2) {
                self.saladLabel.text = dish
            } else if (index >= 3 && index <= 5) {
                self.soupLabel.text = dish
            } else if (index >= 6 && index <= 8) {
                self.mainLabel.text = dish
            } else if (index >= 9 && index <= 11) {
                self.garnishLabel.text = dish
            }
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion:
            nil)
    }
    
}



