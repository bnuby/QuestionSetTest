//
//  SearchUITableView.swift
//  FinanceQuizApp
//
//  Created by D0515211 on 2017/6/25.
//  Copyright © 2017年 訪客使用者. All rights reserved.
//

import UIKit

class SearchUITableView: UITableView , UITableViewDelegate , UITableViewDataSource {
    var LicenseGrade = [String]()
    var LicenseName = [String]()
    var ExamSet : [ExamSet] = []
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchUITableViewCell
        cell.ExamSet.text =  "\(indexPath.row)"
        
        return cell
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class SearchUITableViewCell : UITableViewCell{
    
    @IBOutlet weak var LicenseGrade: UILabel!
    @IBOutlet weak var LicenseName: UILabel!
    @IBOutlet weak var ExamSet: UILabel!
    
}
