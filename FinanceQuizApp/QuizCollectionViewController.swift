//
//  QuizCollectionViewController.swift
//  test
//
//  Created by Gibson Kong on 04/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class QuizCollectionViewController: UIViewController {
    
    @IBOutlet var AllButton: [UIButton]!
    var processType = ""
    
    @IBAction func myFeatureQuiz(_ sender: Any){
        processType = "FeaturedQuiz"
        performSegue(withIdentifier: "PageSwitch", sender: self)
    }
    @IBAction func myMarkedQuiz(_ sender: Any){
        processType = "MarkedQuiz"
        performSegue(withIdentifier: "PageSwitch", sender: self)
    }
    
    @IBAction func EverWrongQuiz(_ sender: Any){
        processType = "EverWrongQuiz"
        performSegue(withIdentifier: "PageSwitch", sender: self)
    }
    
    @IBAction func theEazierWrongQuiz(_ sender: Any){
        processType = "TheEazierWrongQuiz"
        performSegue(withIdentifier: "PageSwitch", sender: self)
    }
    
    @IBOutlet var buttonStackView: UIStackView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "PageSwitch"{
            let destination = segue.destination as! EverWrongQuizViewController
            destination.sourceProcessType = processType
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ButtonAdjust(AllButton)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}
