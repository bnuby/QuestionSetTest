//
//  ViewController.swift
//  test
//
//  Created by 訪客使用者 on 2017/5/3.
//  Copyright © 2017年 訪客使用者. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UISearchBarDelegate,UISearchDisplayDelegate {

//    @IBInspectable var jsonFileName : String!
//    var ProfessionSet : [professionType] = []

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet var InnerCollectionView: UICollectionView!
    @IBOutlet var SearchTableView: SearchUITableView!
    var examSet = [ExamSet]()
    var LicenseGrade = [String]()
    var LicenseName = [String]()
    var isSearching = false
    var QuizDetail : [[String:Int]] = []
    var QuizDetails : [String:Int] = ["ProfessionSet":0,"LicenseGrade":0,"LicenseType":0,"ExamSet":0]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.returnKeyType = .done
        navigationItem.titleView = searchBar
        
        view.addSubview(InnerCollectionView)
        InnerCollectionView.alpha = 0
        InnerCollectionView.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(_:)))
        tap.cancelsTouchesInView = false
        CollectionView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        examSet.removeAll()
        LicenseGrade.removeAll()
        LicenseName.removeAll()
        
        if searchText != "" {
            for (a,i) in ProfessionSet.enumerated(){
                for (b,j) in i.LicenseGrade.enumerated(){
                    for (c,k) in j.LicenseType.enumerated(){
                        for (d,l) in k.ExamSet.enumerated(){
                            if l.name.contains(searchText){
                                QuizDetail.append(["ProfessionSet":a,"LicenseGrade":b,"LicenseType":c,"ExamSet":d])
                                examSet.append(l)
                                LicenseGrade.append(j.Grade)
                                LicenseName.append(k.LicenseName)
                            }
                        }
                    }
                }
            }
            print("here")
            SearchTableView.ExamSet = examSet
            SearchTableView.LicenseGrade = LicenseGrade
            SearchTableView.LicenseName = LicenseName
        }
        SearchTableView.reloadData()
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        SearchTableView.frame = CGRect(x: 0 , y: 20 + navigationItem.titleView!.frame.size.height, width: view.frame.width, height: view.frame.height - navigationItem.titleView!.frame.size.height - 20)
        view.addSubview(SearchTableView)
        isSearching = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        isSearching = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        SearchTableView.removeFromSuperview()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func tap(_ sender : UIGestureRecognizer){

        if InnerCollectionView.isHidden == false{
            
            InnerCollectionViewHide()
            
        }
        navigationItem.titleView?.endEditing(true)
        
    }
    
    func InnerCollectionViewHide(){
        guard let indexpath = self.CollectionView.indexPathsForSelectedItems?.first else {
            print("get indexpath error")
            return
        }
        UIView.animate(withDuration: 0.3, animations: {
            let cell = self.CollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexpath)
            self.InnerCollectionView.frame = self.getCellFrame(cell, self.CollectionView)
            self.InnerCollectionView.alpha = 0
            
        }, completion: { (true) in
            self.InnerCollectionView.isHidden = true
        })
    }
    
    func getCellFrame(_ collectionViewCell : UICollectionViewCell,_ collectionView : UICollectionView) -> CGRect{
        var frame = collectionViewCell.frame
        frame.origin.y += (collectionView.frame.origin.x + collectionView.contentInset.top + collectionView.contentInset.bottom)        
        return frame
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == InnerCollectionView{
            
            return ProfessionSet[InnerCellCount].LicenseGrade.count
        }
        return 1
    }
    var InnerCellCount = 0

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == InnerCollectionView{
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "InnerCellHeader", for: indexPath) as! InnerCollectionReuseable
            header.textlbl.text = ProfessionSet[InnerCellCount].LicenseGrade[indexPath.section].Grade
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView != InnerCollectionView{
            return UIEdgeInsets(top: collectionView.frame.height * 0.1, left: 10, bottom: 10, right: 10)
        }
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == InnerCollectionView{
           return ProfessionSet[InnerCellCount].LicenseGrade[section].LicenseType.count
        }
        return ProfessionSet.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == InnerCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InnerCell", for: indexPath) as! InnerCollectionCell
            cell.textlbl.text = ProfessionSet[InnerCellCount].LicenseGrade[indexPath.section].LicenseType[indexPath.row].LicenseName
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionCell
        cell.textlbl.text = ProfessionSet[indexPath.row].ProfessionName
        cell.frame.size.width = view.frame.width * 0.7 / 3
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == InnerCollectionView {
            let lbl = UILabel()
            lbl.frame.size = CGSize(width: collectionView.bounds.width, height: 200)
            lbl.adjustsFontSizeToFitWidth = true
            lbl.minimumScaleFactor = 0.4
            lbl.lineBreakMode = .byClipping
            lbl.numberOfLines = 0
            lbl.text = ProfessionSet[InnerCellCount].LicenseGrade[section].Grade

            lbl.sizeToFit()
            return CGSize(width: collectionView.bounds.width, height: lbl.bounds.height + 30)
        }
        return CGSize(width: collectionView.frame.width, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == InnerCollectionView{
            if view.frame.width <= 320 {
                return CGSize(width: view.frame.width * 0.85, height: view.frame.height * 0.2 / 3)
            }
            return CGSize(width: view.frame.width * 0.85 / 2 , height: view.frame.height * 0.2 / 3)
        }
        return CGSize(width: view.frame.width * 0.8 / 3, height: view.frame.height * 0.5 / 3)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView != InnerCollectionView && InnerCollectionView.isHidden == true{
            InnerCellCount = indexPath.row
            InnerCollectionView.reloadData()
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            InnerCollectionView.frame = self.getCellFrame(cell, self.CollectionView)
            InnerCollectionView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.InnerCollectionView.frame = CGRect(x: self.view.center.x - self.view.frame.width * 0.9 / 2, y: self.view.center.y - self.view.frame.height * 0.75 / 2, width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.75)
                self.InnerCollectionView.alpha = 1
            })
        }else if collectionView == InnerCollectionView{
            InnerCollectionViewHide()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChooseExamSet"{
            let indexPath = InnerCollectionView.indexPathsForSelectedItems?.last
                let destination = segue.destination as! ExamSetTableViewController
            destination.licenseType = ProfessionSet[InnerCellCount].LicenseGrade[indexPath!.section].LicenseType[indexPath!.row]
            destination.QuizDetail["ProfessionSet"] = InnerCellCount
            destination.QuizDetail["LicenseGrade"] =  indexPath!.section
            destination.QuizDetail["LicenseType"] = indexPath!.row
            
        } else if segue.identifier == "SearchStartQuiz" {
            let destination = segue.destination as! DoingQuizViewController
            let selectedrow = SearchTableView.indexPathForSelectedRow!.row
            let Set = examSet[selectedrow].clone()
            destination.QuizDetail = QuizDetail[selectedrow]
            Set.shuffle()
            destination.ExamSet = Set
        }
        
    }
    
    @IBAction func unWindToQuizSetView(forSegue:UIStoryboardSegue){ }
    

}

extension ViewController : UITableViewDataSource, UITableViewDelegate  {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchUITableViewCell
        cell.ExamSet.text =  examSet[indexPath.row].name
        cell.LicenseName.text = LicenseName[indexPath.row]
        cell.LicenseGrade.text = LicenseGrade[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "SearchStartQuiz", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    

}



// Collection Class


class CollectionCell : UICollectionViewCell{
    @IBOutlet weak var textlbl: UILabel!
    
}

class InnerCollectionReuseable : UICollectionReusableView{
    @IBOutlet weak var textlbl: UILabel!
}

class InnerCollectionCell : UICollectionViewCell{
    @IBOutlet weak var textlbl: UILabel!
}


