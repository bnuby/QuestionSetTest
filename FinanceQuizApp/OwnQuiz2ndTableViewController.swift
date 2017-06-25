//
//  OwnQuiz2ndTableViewController.swift
//  FinanceQuizApp
//
//  Created by D0515211 on 2017/6/24.
//  Copyright © 2017年 訪客使用者. All rights reserved.
//

import UIKit

class OwnQuiz2ndTableViewController: UITableViewController {
    
    var sourceProcessType = ""
    var MarkedQuiz : [MarkedQuiz] = []
    var TheEazierWrongQuiz : [TheEazierWrongQuiz] = []
    var QuizDetail = ["ProfessionId" : 0, "LicenseGrade" : 0, "LicenseType" : 0]
    var filter : [Dictionary<String,Int>] = []
    @IBOutlet weak var ExamSetlbl: UILabel!
    @IBOutlet weak var Quizlbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "BackGround"))
        if sourceProcessType == "MarkedQuiz" {
            print(MarkedQuiz)
            for i in MarkedQuiz{
                if i.professionSet.toInt() == QuizDetail["ProfessionId"] && i.licenseGrade.toInt() == QuizDetail["LicenseGrade"] && i.licenseType.toInt() == QuizDetail["LicenseType"]{
                    filter.append(["ExamSet" : i.examSet.toInt() ,"Quiz": i.quizID.toInt()])
                }
            }
        } else if sourceProcessType == "TheEazierWrongQuiz" {
            print(TheEazierWrongQuiz)

            for i in TheEazierWrongQuiz{
                if i.professionSet.toInt() == QuizDetail["ProfessionId"] && i.licenseGrade.toInt() == QuizDetail["LicenseGrade"] && i.licenseType.toInt() == QuizDetail["LicenseType"]{
                    filter.append(["ExamSet" : i.examSet.toInt() ,"Quiz": i.quizID.toInt()])
                }
            }
        }
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
        return filter.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OwnQuiz2ndTableViewCell
        
        // Configure the cell...
        cell.ExamSetlbl.text = ProfessionSet[QuizDetail["ProfessionId"]!].LicenseGrade[QuizDetail["LicenseGrade"]!].LicenseType[QuizDetail["LicenseType"]!].ExamSet[filter[indexPath.row]["ExamSet"]!].name
        
        cell.Quizlbl.text = ProfessionSet[QuizDetail["ProfessionId"]!].LicenseGrade[QuizDetail["LicenseGrade"]!].LicenseType[QuizDetail["LicenseType"]!].ExamSet[filter[indexPath.row]["ExamSet"]!].quizList[filter[indexPath.row]["Quiz"]!].question

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowOwnQuiz", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowOwnQuiz" {
            let destination = segue.destination as! OwnQuiz2ndViewController
            let indexPath = tableView.indexPathForSelectedRow!
            destination.quiz = ProfessionSet[QuizDetail["ProfessionId"]!].LicenseGrade[QuizDetail["LicenseGrade"]!].LicenseType[QuizDetail["LicenseType"]!].ExamSet[filter[indexPath.row]["ExamSet"]!].quizList[filter[indexPath.row]["Quiz"]!]
        }
    }
    
}


class OwnQuiz2ndTableViewCell : TableViewCell{
    @IBOutlet weak var ExamSetlbl: UILabel!
    @IBOutlet weak var Quizlbl: UILabel!
    
}
