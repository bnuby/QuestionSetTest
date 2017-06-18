//
//  AccountViewController.swift
//  test
//
//  Created by Gibson Kong on 04/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet var Namelbl: UILabel!
    @IBOutlet var Jobslbl: UILabel!
    @IBInspectable var jsonFileName : String!

    @IBAction func logOut(){
        print("hello")
        self.performSegue(withIdentifier: "unwindToLoginPage", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readJson(jsonFileName)
        for i in ProfessionSet[0].LicenseGrade[0].LicenseType[0].ExamSet[0].quizList{
            print(i.id)
        }
        // Do any additional setup after loading the view.
        print((loginViewController() ).loginUser)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func unWindToProfile (for unwindSegue: UIStoryboardSegue) { }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
