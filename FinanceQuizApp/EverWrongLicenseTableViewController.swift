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
    
    @IBOutlet var Header: UITableViewCell!
    
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
    
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.font = UIFont(name: "Futura", size: 15)
//    }
//    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height * 0.05
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.05
    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = Header as! CustomTableHeader
//        header.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25)
//        header.headerlbl.text = ProfessionSet[getProfessionSetId].LicenseGrade[section].Grade
//        header.headerlbl.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25)
//        return header
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height * 0.05))
        returnedView.backgroundColor = UIColor(red: 237/255, green: 236/255, blue: 241/255, alpha: 1)
        
        let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width * 0.5, height: view.frame.height * 0.05))

        label.lineBreakMode = .byClipping
        label.textAlignment = .center
        label.clipsToBounds = true
        label.font = UIFont(name: label.font.fontName, size: 10)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.01
        label.adjustsFontSizeToFitWidth = true
        label.text = ProfessionSet[getProfessionSetId].LicenseGrade[section].Grade
        label.textColor = .black
        label.sizeToFit()

        returnedView.addSubview(label)
        label.leftAnchor.constraint(equalTo: returnedView.leftAnchor)
        label.bottomAnchor.constraint(equalTo: returnedView.bottomAnchor)
        label.topAnchor.constraint(equalTo: returnedView.topAnchor)

        return returnedView
    }

    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        return ProfessionSet[getProfessionSetId].LicenseGrade[section].Grade
//    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = ProfessionSet[getProfessionSetId].LicenseGrade[indexPath.section].LicenseType[LicenseType[indexPath.section][indexPath.row]].LicenseName
        cell.textLabel?.font = UIFont(name: cell.textLabel!.font.fontName, size: 10)

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


class CustomTableHeader : UITableViewCell{
    @IBOutlet weak var headerlbl: UILabel!
    
}
