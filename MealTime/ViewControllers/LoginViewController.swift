//
//  LoginViewController.swift
//  MealTime
//
//  Created by Ziong on 6/6/18.
//  Copyright © 2018 Ziong Le. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    private var name: String?
    private var photoURL : URL?
    
    override func loadView() {
        super.loadView()
        
        // Google Sheet API
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly, kGTLRAuthScopeSheetsDrive, kGTLRAuthScopeSheetsDriveReadonly, kGTLRAuthScopeSheetsSpreadsheets]
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Failed to log into Google", error)
            return
        }
        print("Successfully logged into Google",user)
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let err = error {
                print("Log in failed", err)
                return
            }
            
            if let user = Auth.auth().currentUser {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                self.photoURL = user.photoURL
                self.name = user.displayName
            }
            
            
            let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let selectPersonViewController = mainStoryBoard.instantiateViewController(withIdentifier: "SelectPersonViewContoller") as! SelectPersonViewController
            // Finds user to display his menu
            selectPersonViewController.username = self.name
            self.present(selectPersonViewController, animated: true, completion: nil)
        }
    }
    
}

