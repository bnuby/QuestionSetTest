//
//  EverWrongQuizListTableViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 14/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class EverWrongQuizListTableViewController: UITableViewController {
    
    var QuizDetail : [String : Int] = ["getProfessionSetId" : 0, "getExamSet" : 0, "getQuizSet": 0]
    var EverWrongQuizList : [EverWrongQuiz]!
    var QuizList : [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarController?.prefersStatusBarHidden == true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        for i in EverWrongQuizList {
            if Int(i.professionSet) == QuizDetail["getProfessionSetId"] && Int(i.examSet) == QuizDetail["getExamSet"] && Int(i.noOfQuizSet) == QuizDetail["getQuizSet"] {
                if !QuizList.contains(Int(i.quizID)){
                    QuizList.append(Int(i.quizID))
                }
            }
            
        }
        print(QuizDetail["getProfessionSetId"],QuizDetail["getExamSet"],QuizDetail["getQuizSet"])

        return QuizList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let question = ProfessionSet[QuizDetail["getProfessionSetId"]!].ExamSet[QuizDetail["getExamSet"]!].QuizSet[QuizDetail["getQuizSet"]!].quizList[QuizList[indexPath.row]].question
        Cell.textLabel?.text = question
        return Cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DoingEverWrongQuiz"{
            let destination = segue.destination as! DoingEverWrongQuizViewController
            destination.getQuiz = ProfessionSet[QuizDetail["getProfessionSetId"]!].ExamSet[QuizDetail["getExamSet"]!].QuizSet[QuizDetail["getQuizSet"]!].quizList[QuizList[tableView.indexPathForSelectedRow!.row]]
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
