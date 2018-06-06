//
//  ViewController.swift
//  MealTime
//
//  Created by Ziong on 6/6/18.
//  Copyright © 2018 Ziong Le. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func signOutButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let signInButton = GIDSignInButton()
        //        signInButton.frame = CGRect(x: 16, y : 116 + 66, width: view.frame.width - 32, height: 100)
        //        signInButton.center = view.center
        //        view.addSubview(signInButton)
        //        GIDSignIn.sharedInstance().uiDelegate = self
        //        GIDSignIn.sharedInstance().signIn()
        
        
    }
    
}

