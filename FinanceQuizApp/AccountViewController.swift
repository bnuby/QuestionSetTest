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
    var get_id = ""
    var get_job = ""

    @IBAction func logOut(){
        self.performSegue(withIdentifier: "unwindToLoginPage", sender: self)
        loginViewController().User.removeObject(forKey: "user")
        loginViewController().User.removeObject(forKey: "job")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        get_id = loginViewController().User.string(forKey: "user")!

        get_job = loginViewController().User.string(forKey: "job")!
        readJson(jsonFileName)
        
        Namelbl.text = get_id
        Jobslbl.text = get_job
//        for i in ProfessionSet[0].LicenseGrade[0].LicenseType[0].ExamSet[0].quizList{
//            print(i.id)
//        }
        // Do any additional setup after loading the view.
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
