//
//  ProfileSettingViewController.swift
//  FinanceQuizApp
//
//  Created by D0515211 on 2017/6/24.
//  Copyright © 2017年 訪客使用者. All rights reserved.
//

import UIKit

class ProfileSettingViewController: UIViewController {
    
    @IBAction func BackButton(){
        self.performSegue(withIdentifier: "unWindToProfile", sender: self)
    }
    
    @IBOutlet var navigation: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.frame.origin.y = 0
        navigation.frame.size.height = 60
        navigation.frame.size.width = view.frame.width
        view.addSubview(navigation)
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

}
