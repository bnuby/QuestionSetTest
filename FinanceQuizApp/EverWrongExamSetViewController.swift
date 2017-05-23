//
//  EverWrongQuizListViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 14/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class EverWrongQuizListViewController: UITableViewController {
    
    var getProfessionSetId : Int!
    var EverWrongQuizList : [EverWrongQuiz]!
    var ExamSet : [Int] = []
    var QuizSet : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        for i in EverWrongQuizList {
            if !ExamSet.contains(Int(i.examSet)){
                ExamSet.append(Int(i.examSet))
            }
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for i in EverWrongQuizList {
            if !QuizSet.contains(Int(i.noOfQuizSet)){
                QuizSet.append(Int(i.noOfQuizSet))
            }
        }
        return ExamSet.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ProfessionSet[getProfessionSetId].ExamSet[ExamSet[section]].QuizGrade
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        Cell.textLabel?.text = ProfessionSet[getProfessionSetId].ExamSet[ExamSet[indexPath.section]].QuizSet[QuizSet[indexPath.row]].name
        return Cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEverWrongQuizList" {
            let destination = segue.destination as! EverWrongQuizListTableViewController
            destination.QuizDetail["getProfessionSetId"] = getProfessionSetId
            destination.QuizDetail["getExamSet"] = ExamSet[(tableView.indexPathForSelectedRow?.section)!]
            destination.QuizDetail["getQuizSet"] = QuizSet[(tableView.indexPathForSelectedRow?.row)!]
            destination.EverWrongQuizList = EverWrongQuizList
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

