//
//  EverWrongExamSetTableViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 15/06/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class EverWrongExamSetTableViewController: UITableViewController {
    var EverWrongQuiz : [EverWrongQuiz] = []
    var QuizDetail = ["ProfessionId" : 0, "LicenseGrade" : 0, "LicenseType" : 0]
    var ExamSet : [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "BackGround"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in EverWrongQuiz{
            if i.professionSet.toInt() == QuizDetail["ProfessionId"] && i.licenseGrade.toInt() == QuizDetail["LicenseGrade"] && i.licenseType.toInt() == QuizDetail["LicenseType"]{
                if !ExamSet.contains(where: { (a) -> Bool in
                    a == i.examSet.toInt()
                }){
                     ExamSet.append(i.examSet.toInt())
                }
            }
        }
        print(ExamSet)
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
        
        return ExamSet.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = ProfessionSet[QuizDetail["ProfessionId"]!].LicenseGrade[QuizDetail["LicenseGrade"]!].LicenseType[QuizDetail["LicenseType"]!].ExamSet[ExamSet[indexPath.row]].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowEverWrongQuizList"{
            let destination = segue.destination as! EverWrongQuizListTableViewController
            destination.EverWrongQuiz = EverWrongQuiz
            destination.QuizDetail["ProfessionId"] = QuizDetail["ProfessionId"]
            destination.QuizDetail["LicenseGrade"] = QuizDetail["LicenseGrade"]
            destination.QuizDetail["LicenseType"] = QuizDetail["LicenseType"]
            destination.QuizDetail["ExamSet"] = ExamSet[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    

}
