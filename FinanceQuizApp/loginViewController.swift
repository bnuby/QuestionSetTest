//
//  loginViewController.swift
//  test
//
//  Created by Gibson Kong on 04/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit
import CoreData

class loginViewController: UIViewController {
    
    var loginData = ["user" : "admin" , "password" : ""]
    let User = UserDefaults()
    @IBOutlet var Username: UITextField!
    @IBOutlet var Password: UITextField!
    var Account : [AccountMO] = []

    
    
    override func viewWillAppear(_ animated: Bool) {
        Username.isEnabled = true
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.red.cgColor,UIColor.blue.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: view.frame.height)
        gradient.endPoint = CGPoint(x: view.bounds.width, y: view.bounds.height)
        
        let a = RadialGradientLayer()
        
        
        view.layer.insertSublayer(a, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AccountMO")
            do {
                
            Account = try context.fetch(fetchRequest) as! [AccountMO]
            } catch _ as NSError {
                
            }
            
        }
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (User.string(forKey: "user") != nil){
            Username.text = User.string(forKey: "user")
            Username.isEnabled = false
            self.performSegue(withIdentifier: "loginSucess", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Login(_ sender: Any) {
        let loginUser = Username.text!
        if loginUser == loginData["user"] && Password.text == loginData["password"]{
            User.set(loginUser, forKey: "user")
            User.set("Student", forKey: "job")
            User.set("noPic", forKey: "profilePic")
            performSegue(withIdentifier: "loginSucess", sender: self)
        }
        let alertController = UIAlertController(title: "Login Failed", message: "Invalid username or password", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func loginAsGuest(_ sender: Any) {
        User.set("Guest", forKey: "user")
        User.set("Unknown", forKey: "job")
//        User.set("noPic", forKey: "profilePic")
        let data = NSKeyedArchiver.archivedData(withRootObject: #imageLiteral(resourceName: "noPic"))
        User.set(data, forKey: "profilePic")

        print("here\n\n\n\n\n")
        print(User.value(forKey: "Pic"))
        self.performSegue(withIdentifier: "loginSucess", sender: self)
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {}
    
}
