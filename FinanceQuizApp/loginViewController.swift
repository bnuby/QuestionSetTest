//
//  loginViewController.swift
//  test
//
//  Created by Gibson Kong on 04/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    
    var loginData = ["user" : "admin" , "password" : ""]

    @IBOutlet var Username: UITextField!
    @IBOutlet var Password: UITextField!
    
    @IBAction func Login(_ sender: Any) {
        loginUser = Username.text!
        if loginUser == loginData["user"] && Password.text == loginData["password"]{
            performSegue(withIdentifier: "loginSucess", sender: self)
        }
        let alertController = UIAlertController(title: "Login Failed", message: "Invalid username or password", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        loginUser = "nil"
    }
    
    @IBAction func loginAsGuest(_ sender: Any) {
        
        self.performSegue(withIdentifier: "loginSucess", sender: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if loginUser == loginData["user"] && Password.text == loginData["password"]{
            performSegue(withIdentifier: "loginSucess", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(loginUser)
        

        // Do any additional setup after loading the view.
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
    var loginUser : String{
        get{
            if let returnValue = UserDefaults.standard.object(forKey: "loginUser") as? String {
                return returnValue
            } else {
                return "nil" //Default value
            }
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "loginUser")
            UserDefaults.standard.synchronize()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {}
    
}
