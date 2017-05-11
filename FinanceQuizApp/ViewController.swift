//
//  ViewController.swift
//  test
//
//  Created by 訪客使用者 on 2017/5/3.
//  Copyright © 2017年 訪客使用者. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

//    @IBInspectable var jsonFileName : String!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet var InnerCollectionView: UICollectionView!
//    var ProfessionSet : [professionType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
               
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        //Alternative that also works
        navigationItem.titleView = searchController.searchBar
        
        // read Json File Which call testing.json
//        readJson(jsonFileName)
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
        print(collectionViewCell.frame.origin,collectionViewCell.bounds.origin)
        
        return frame
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
        cell.frame.size.width = view.frame.width * 0.7 / 3
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == InnerCollectionView{
            if view.frame.width <= 320 {
                return CGSize(width: view.frame.width * 0.8, height: view.frame.height * 0.2 / 3)
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
        if segue.identifier == "ReadytoStartPage"{
            let indexPath = InnerCollectionView.indexPathsForSelectedItems?.last
                let destination = segue.destination as! ReadyDoingQuizViewController
            destination.QuizSet = ProfessionSet[InnerCellCount].ExamSet[indexPath!.section].QuizSet[indexPath!.row]
            destination.QuizDetail["ProfessionSet"] = InnerCellCount
            destination.QuizDetail["ExamSet"] =  indexPath!.section
            destination.QuizDetail["noOfQuizSet"] = indexPath!.row
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


