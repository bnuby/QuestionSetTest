//
//  QuizHistoryViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 05/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit
import CoreData

class QuizHistoryViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource {
    @IBOutlet var navigation: UINavigationBar!
    @IBAction func BackButton(){
        self.performSegue(withIdentifier: "unWindToProfile", sender: self)
    }
    var History : [History]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.frame.origin.y = 20
        navigation.frame.size.width = view.frame.width
        view.addSubview(navigation)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = true
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
            do {
                History = try context.fetch(fetchRequest) as! [History]
            } catch let error as NSError {
                print("error : \(error)")
            }
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
        tableView.separatorStyle = .singleLine
        if History.count > 0 {
            return History.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryCell
        let history = History[indexPath.row]
        cell.ProfessionType.text = ProfessionSet[history.professionSet.toInt()].ProfessionName
        cell.QuizSetName.text =  ProfessionSet[history.professionSet.toInt()].LicenseGrade[history.licenseGrade.toInt()].LicenseType[history.licenseType.toInt()].ExamSet[history.examSet.toInt()].name
        cell.Score.text = "\(History[indexPath.row].score)%"
        cell.numberOfCorrect.text = "\(History[indexPath.row].numberOfCorrect)"
        
//        var subview = UIView(frame: CGRect(x: cell.frame.origin.x + 5, y: cell.frame.origin.y + 10, width: cell.frame.width - 10, height: cell.frame.height - 20))
//        subview.layer.backgroundColor = UIColor.gray.cgColor
//        subview.layer.cornerRadius = subview.frame.height/2-20
//        cell.addSubview(subview)
//        cell.sendSubview(toBack: subview)
//        print("here")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

class HistoryCell : UITableViewCell{
    @IBOutlet var ProfessionType: UILabel!
    @IBOutlet var QuizSetName: UILabel!
    @IBOutlet var numberOfCorrect: UILabel!
    @IBOutlet var Score: UILabel!
    
}
