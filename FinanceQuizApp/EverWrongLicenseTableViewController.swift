//
//  EverWrongLicenseTableViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 15/06/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class EverWrongLicenseTableViewController: UITableViewController {
    var EverWrongQuiz : [EverWrongQuiz] = []
    var MarkedQuiz : [MarkedQuiz] = []
    var TheEazierWrongQuiz : [TheEazierWrongQuiz] = []
    var getProfessionSetId : Int!
    var LicenseType : [[Int]] = [[]]
    var sourceProcessType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "BackGround"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in 0 ..< ProfessionSet[getProfessionSetId].LicenseGrade.count{
            LicenseType.append([])
            if sourceProcessType == "EverWrongQuiz" {
                for j in EverWrongQuiz{
                    if j.professionSet == Int16(getProfessionSetId) && j.licenseGrade.toInt() == i{
                        if !LicenseType[i].contains(where: { (a) -> Bool in
                            return a == j.licenseGrade.toInt()
                        }){
                            LicenseType[i].append(Int(j.licenseType))
                        }
                    }
                }
            } else if sourceProcessType == "MarkedQuiz" {
                for j in MarkedQuiz{
                    if j.professionSet == Int16(getProfessionSetId) && j.licenseGrade.toInt() == i{
                        if !LicenseType[i].contains(where: { (a) -> Bool in
                            return a == j.licenseGrade.toInt()
                        }){
                            LicenseType[i].append(Int(j.licenseType))
                        }
                    }
                }
            } else if sourceProcessType == "TheEazierWrongQuiz" {
                for j in TheEazierWrongQuiz{
                    if j.professionSet == Int16(getProfessionSetId) && j.licenseGrade.toInt() == i{
                        if !LicenseType[i].contains(where: { (a) -> Bool in
                            return a == j.licenseGrade.toInt()
                        }){
                            LicenseType[i].append(Int(j.licenseType))
                        }
                    }
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
        return ProfessionSet[getProfessionSetId].LicenseGrade.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return LicenseType[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ProfessionSet[getProfessionSetId].LicenseGrade[section].Grade
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = ProfessionSet[getProfessionSetId].LicenseGrade[indexPath.section].LicenseType[LicenseType[indexPath.section][indexPath.row]].LicenseName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sourceProcessType == "EverWrongQuiz"{
            performSegue(withIdentifier: "ShowEverWrongExamSet", sender: self)
        }else{
            performSegue(withIdentifier: "2ndView", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowEverWrongExamSet"{
            let destination = segue.destination as! EverWrongExamSetTableViewController
            let section = tableView.indexPathForSelectedRow?.section
            let row = tableView.indexPathForSelectedRow?.row
            destination.EverWrongQuiz = EverWrongQuiz
            destination.QuizDetail["ProfessionId"] = getProfessionSetId
            destination.QuizDetail["LicenseGrade"] = section
            destination.QuizDetail["LicenseType"] = LicenseType[section!][row!]
        } else {
            let destination = segue.destination as! OwnQuiz2ndTableViewController
            let section = tableView.indexPathForSelectedRow?.section
            let row = tableView.indexPathForSelectedRow?.row
            destination.TheEazierWrongQuiz = TheEazierWrongQuiz
            destination.MarkedQuiz = MarkedQuiz
            destination.sourceProcessType = sourceProcessType
            destination.QuizDetail["ProfessionId"] = getProfessionSetId
            destination.QuizDetail["LicenseGrade"] = section
            destination.QuizDetail["LicenseType"] = LicenseType[section!][row!]
        }
    }
    

}
