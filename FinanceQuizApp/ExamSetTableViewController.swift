//
//  ExamSetTableViewController.swift
//  FinanceQuizApp
//
//  Created by RTC13 on 2017/6/12.
//  Copyright © 2017年 訪客使用者. All rights reserved.
//

import UIKit

class ExamSetTableViewController: UITableViewController {
    
    var licenseType : LicenseType!
    let searchController = UISearchController(searchResultsController: nil)
    var QuizDetail : [String:Int] = ["ProfessionSet":0,"LicenseGrade":0,"LicenseType":0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "BackGround"))
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
        return licenseType.ExamSet.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.05
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.font = UIFont(name: cell.textLabel!.font.fontName, size: 10)
//        cell.backgroundColor = UIColor.clear
//        cell.textLabel?.minimumScaleFactor = 0.01
//        cell.textLabel?.lineBreakMode = .byClipping
//        cell.textLabel?.adjustsFontSizeToFitWidth = true
//        cell.textLabel?.numberOfLines = 1

        cell.textLabel?.text = licenseType.ExamSet[indexPath.row].name
//        cell.textLabel?.sizeToFit()

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ReadytoStartPage"{
            let destination = segue.destination as! ReadyDoingQuizViewController
            destination.QuizSet = ProfessionSet[QuizDetail["ProfessionSet"]!].LicenseGrade[QuizDetail["LicenseGrade"]!].LicenseType[QuizDetail["LicenseType"]!].ExamSet[(tableView.indexPathForSelectedRow?.row)!].clone()
            destination.QuizDetail["ProfessionSet"] = QuizDetail["ProfessionSet"]
            destination.QuizDetail["LicenseGrade"] = QuizDetail["LicenseGrade"]
            destination.QuizDetail["LicenseType"] = QuizDetail["LicenseType"]
            destination.QuizDetail["ExamSet"] = tableView.indexPathForSelectedRow?.row
        }
    }

}
