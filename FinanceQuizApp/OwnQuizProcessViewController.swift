//
//  OwnQuizProcessViewController.swift
//  test
//
//  Created by Gibson Kong on 04/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit
import CoreData

class OwnQuizProcessViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var sourceProcessType:String!
    
    var sourceDict = ["myFeaturedQuiz":1,"myMarkedQuiz":2,"theEazierWrongQuiz":3]
    var MarkedQuiz : [MarkedQuiz] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        switch sourceDict[sourceProcessType]!{
        case 1:
            let fetchMarkedQuiz = NSFetchRequest<NSFetchRequestResult>(entityName: "MarkedQuiz")
            do{
                MarkedQuiz = try context?.fetch(fetchMarkedQuiz) as! [MarkedQuiz]
            } catch let error as NSError{
                print(error)
            }
            
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sourceDict[sourceProcessType]!{
        case 1:
            return MarkedQuiz.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.professionType.text = "\(ProfessionSet[Int(MarkedQuiz[indexPath.row].professionSet)].ProfessionName!)"
       
        cell.ExamGrade.text = "\(ProfessionSet[Int(MarkedQuiz[indexPath.row].professionSet)].ExamSet[Int(MarkedQuiz[indexPath.row].examSet)].QuizGrade!)"
        
         cell.ExamSet.text = "\(ProfessionSet[Int(MarkedQuiz[indexPath.row].professionSet)].ExamSet[Int(MarkedQuiz[indexPath.row].examSet)].QuizSet[Int(MarkedQuiz[indexPath.row].noOfQuizSet)].name!)"
        let ExamSet = ProfessionSet[Int(MarkedQuiz[indexPath.row].professionSet)].ExamSet[Int(MarkedQuiz[indexPath.row].examSet)].QuizSet[Int(MarkedQuiz[indexPath.row].noOfQuizSet)]
        cell.QuizQuestion.text = "\(ExamSet.quizList[Int(MarkedQuiz[indexPath.row].quizID)].question!)"
        
        
//        "\(ProfessionSet[Int(MarkedQuiz[indexPath.row].professionSet)].ExamSet[Int(MarkedQuiz[indexPath.row].examSet)].QuizSet[Int(MarkedQuiz[indexPath.row].noOfQuizSet)].quizList[Int(MarkedQuiz[indexPath.row].quizID)].question)"
        
        return cell
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


class TableViewCell : UITableViewCell{
    @IBOutlet var professionType: UILabel!
    @IBOutlet var ExamGrade: UILabel!
    @IBOutlet var ExamSet: UILabel!
    @IBOutlet var QuizQuestion: UILabel!
    
}
