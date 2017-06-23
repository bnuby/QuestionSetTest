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
    @IBAction func Login(_ sender: Any) {
        let loginUser = Username.text!
        if loginUser == loginData["user"] && Password.text == loginData["password"]{
            User.set(loginUser, forKey: "user")
            User.set("Student", forKey: "job")
            performSegue(withIdentifier: "loginSucess", sender: self)
        }
        let alertController = UIAlertController(title: "Login Failed", message: "Invalid username or password", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func loginAsGuest(_ sender: Any) {
        User.set("Guest", forKey: "user")
        User.set("Unknown", forKey: "job")
        self.performSegue(withIdentifier: "loginSucess", sender: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        Username.isEnabled = true
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.red.cgColor,UIColor.blue.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: view.frame.height)
        gradient.endPoint = CGPoint(x: view.bounds.width, y: view.bounds.height)
        
        let a = RadialGradientLayer()
        
        
        view.layer.insertSublayer(a, at: 0)
//        if loginUser == loginData["user"] && Password.text == loginData["password"]{
//            performSegue(withIdentifier: "loginSucess", sender: self)
//        }
//        if let id = defaults.string(forKey: "id"){
//            Username.text = id
//        }
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
        
        

        // Do any additional setup after loading the view.
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
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    var loginUser : String{
//        get{
//            if let returnValue = UserDefaults.standard.string(forKey: "loginUser") as? String {
//                return returnValue
//            } else {
//                return "nil" //Default value
//            }
//        }
//        set{
//            UserDefaults.standard.set(newValue, forKey: "loginUser")
//            UserDefaults.standard.synchronize()
//        }
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {}
    
}
