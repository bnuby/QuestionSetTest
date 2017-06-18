//
//  EverWrongQuizListTableViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 14/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class EverWrongQuizListTableViewController: UITableViewController {
    
    var EverWrongQuiz : [EverWrongQuiz] = []
    var QuizDetail = ["ProfessionId" : 0, "LicenseGrade" : 0, "LicenseType" : 0, "ExamSet" : 0]
    var QuizList : [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarController?.prefersStatusBarHidden == true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in EverWrongQuiz {
            if i.professionSet.toInt() == QuizDetail["ProfessionId"] && i.licenseType.toInt() == QuizDetail["LicenseType"] && i.licenseGrade.toInt() == QuizDetail["LicenseGrade"] && i.examSet.toInt() == QuizDetail["ExamSet"]  {
                //                if !QuizList.contains(Int(i.quizID)){
                QuizList.append(i.quizID.toInt())
                //                }
            }
        }
        print(QuizList)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
//        print(QuizDetail["getProfessionSetId"],QuizDetail["getExamSet"],QuizDetail["getQuizSet"])

        return QuizList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let question = ProfessionSet[QuizDetail["ProfessionId"]!].LicenseGrade[QuizDetail["LicenseGrade"]!].LicenseType[QuizDetail["LicenseType"]!].ExamSet[QuizDetail["ExamSet"]!].quizList[QuizList[indexPath.row]].question
        Cell.textLabel?.text = question
        return Cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DoingEverWrongQuiz"{
            let destination = segue.destination as! DoingEverWrongQuizViewController
            destination.getQuiz = ProfessionSet[QuizDetail["ProfessionId"]!].LicenseGrade[QuizDetail["LicenseGrade"]!].LicenseType[QuizDetail["LicenseType"]!].ExamSet[QuizDetail["ExamSet"]!].quizList[QuizList[tableView.indexPathForSelectedRow!.row]]
        }
    }

}
