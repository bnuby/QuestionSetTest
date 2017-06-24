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
    var filter = [["ExamSet" : 0, "LicenseName" : 0, "Quiz" : 0 ]]
    @IBOutlet weak var ExamSetlbl: UILabel!
    @IBOutlet weak var Quizlbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "BackGround"))
        if sourceProcessType == "MarkedQuiz" {
            for i in MarkedQuiz{
                if i.professionSet.toInt() == QuizDetail["ProfessionId"] && i.licenseGrade.toInt() == QuizDetail["LicenseGrade"] && i.licenseType.toInt() == QuizDetail["LicenseType"]{
//                    filter.contains(where: { (j: Dictionary<String, Int>) -> Bool in
//                        j[""] == i.
//                    })
                    filter.append(["ExamSet" : i.examSet.toInt() ,"Quiz": i.quizID.toInt()])
                }
            }
        } else if sourceProcessType == "TheEazierWrongQuiz" {
            
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


class OwnQuiz2ndTableViewCell : TableViewCell{
    @IBOutlet weak var ExamSetlbl: UILabel!
    @IBOutlet weak var Quizlbl: UILabel!
    
}
