//
//  ViewController.swift
//  test
//
//  Created by 訪客使用者 on 2017/5/3.
//  Copyright © 2017年 訪客使用者. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {

    @IBInspectable var jsonFileName : String!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet var InnerCollectionView: UICollectionView!
    var ProfessionSet : [professionType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
               
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        //Alternative that also works
        navigationItem.titleView = searchController.searchBar
        
        // read Json File Which call testing.json
        readJson()
        view.addSubview(InnerCollectionView)
        InnerCollectionView.alpha = 0
        InnerCollectionView.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(_:)))
        tap.cancelsTouchesInView = false
        CollectionView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
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
            self.InnerCollectionView.frame = self.CollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexpath).frame
            self.InnerCollectionView.alpha = 0
            
        }, completion: { (true) in
            self.InnerCollectionView.isHidden = true
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == InnerCollectionView{
            
            return ProfessionSet[InnerCellCount].ExamSet.count
        }
        return 1
    }
    var InnerCellCount = 0

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == InnerCollectionView{
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "InnerCellHeader", for: indexPath) as! InnerCollectionReuseable
            header.textlbl.text = ProfessionSet[InnerCellCount].ExamSet[indexPath.section].QuizGrade
            return header
        }
        return UICollectionReusableView()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == InnerCollectionView{
           return ProfessionSet[InnerCellCount].ExamSet[section].QuizSet.count
            
        }
        return ProfessionSet.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == InnerCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InnerCell", for: indexPath) as! InnerCollectionCell
            
            cell.textlbl.text = ProfessionSet[InnerCellCount].ExamSet[indexPath.section].QuizSet[indexPath.row].name
            cell.textlbl.adjustsFontSizeToFitWidth = true
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionCell
        cell.textlbl.text = ProfessionSet[indexPath.row].ProfessionName
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView != InnerCollectionView && InnerCollectionView.isHidden == true{
            InnerCellCount = indexPath.row
            InnerCollectionView.reloadData()
            InnerCollectionView.frame = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath).frame
            InnerCollectionView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.InnerCollectionView.frame = CGRect(x: self.view.center.x - 200, y: self.view.center.y - 200, width: 390, height: 500)
                self.InnerCollectionView.alpha = 1
            })
        }else if collectionView == InnerCollectionView{
            InnerCollectionViewHide()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReadytoStartPage"{
            let indexPath = InnerCollectionView.indexPathsForSelectedItems?.last
                let destination = segue.destination as! ReadyDoingQuizViewController
            destination.QuizSet = ProfessionSet[InnerCellCount].ExamSet[indexPath!.section].QuizSet[indexPath!.row]
            destination.QuizDetail["ProfessionSet"] = InnerCellCount
            destination.QuizDetail["ExamSet"] =  indexPath!.section
            destination.QuizDetail["noOfQuizSet"] = indexPath!.row
        }
        
    }
    
    private func readJson() {
        do {
            if let file = Bundle.main.url(forResource: jsonFileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    dataProcess(object: object)
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func dataProcess(object : [String: Any]){
        
        // profession_type is the json head
        var profession_type = object["professionSet"] as! [[String:Any]]
        
        for i in 0..<profession_type.count{
            // Get Profession_Type Such As 保險業 && temp is fetch and get Profession
            let temp = professionType(Name: profession_type[i]["profession_type"]! as! String)
            
            // Get Profession_Type.data Such As ExamSet
            let data = profession_type[i]["data"] as! [[String:Any]]
            
            for j in 0..<data.count{
                temp.addExamSet(examSet(data[j]["ExamGrade"] as! String))
                
                // Get Profession_Type.data.ExamSet Such As ExamName
                let ExamSet = data[j]["ExamSet"] as! [[String:Any]]
                for k in 0..<ExamSet.count{
                    temp.ExamSet[j].addQuizSet(quizSet(id: k, name: ExamSet[k]["ExamName"]! as! String))
                    if let QuizSet = ExamSet[k]["QuizSet"] as? [[String:Any]]{
                        for l in 0..<QuizSet.count{
                            let answer = QuizSet[l]["answer"] as! [String]
                            let choice = QuizSet[l]["choice"] as! [String]
                            temp.ExamSet[j].QuizSet[k].addQuiz(quiz(id: QuizSet[l]["id"] as! Int, question: QuizSet[l]["question"] as! String, choice: choice, answer: answer))

                        }
                    }
                    
                }
            }
            
            ProfessionSet.append(temp)
        }
    }
    
    @IBAction func unWindToQuizSetView(forSegue:UIStoryboardSegue){ }
    

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


