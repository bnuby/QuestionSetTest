//
//  ReadyDoingQuizViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 08/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class ReadyDoingQuizViewController: UIViewController {

    var QuizSet : ExamSet!
    var QuizDetail : [String:Int] = ["ProfessionSet":0,"LicenseGrade":0,"LicenseType":0,"ExamSet":0]
    
    @IBAction func StartBtn(_ sender: Any) {
        for i in 0..<QuizSet.quizList.count{
            print(QuizSet.quizList[i].question)
        }
        QuizSet.shuffle()
        
        for i in 0..<QuizSet.quizList.count{
            print(QuizSet.quizList[i].question)
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartQuiz" {
            let destination = segue.destination as! DoingQuizViewController
            destination.ExamSet = QuizSet

            destination.QuizDetail["ProfessionSet"] = self.QuizDetail["ProfessionSet"]
            destination.QuizDetail["LicenseGrade"] =  self.QuizDetail["LicenseGrade"]
            destination.QuizDetail["LicenseType"] =  self.QuizDetail["LicenseType"]
            destination.QuizDetail["ExamSet"] = self.QuizDetail["ExamSet"]
        }
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
