//
//  EverWrongQuizViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 14/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit
import CoreData

class EverWrongQuizViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var EverWrongQuiz : [EverWrongQuiz] = []
    var filterExam : [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EverWrongQuiz")
            do {
                EverWrongQuiz = try context.fetch(fetchRequest) as! [EverWrongQuiz]
            } catch let error as NSError{
                print("error : \(error)")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        for i in EverWrongQuiz {
            if !filterExam.contains(Int(i.professionSet)){
                filterExam.append(Int(i.professionSet))
            }
        }
        
        return filterExam.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let Header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! EverWrongQuizCollectionHeader
        
        if filterExam.count > 0 {
            Header.textlbl.text = "以下為答錯的題目"
        } else {
            Header.textlbl.text = "無錯誤的題目"
        }
        
        return Header
    }
    
    
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EverWrongQuizCollectionCell
        Cell.textlbl.text = ProfessionSet[Int(EverWrongQuiz[indexPath.row].professionSet)].ProfessionName
        
        return Cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEverWrongLicense" {
            let destination = segue.destination as! EverWrongLicenseTableViewController
            destination.EverWrongQuiz = EverWrongQuiz
            destination.getProfessionSetId = filterExam[(collectionView.indexPathsForSelectedItems?.first?.row)!]
        }
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

class EverWrongQuizCollectionCell : UICollectionViewCell{
    @IBOutlet var textlbl: UILabel!
    
}

class EverWrongQuizCollectionHeader : UICollectionReusableView{
    
    @IBOutlet var textlbl: UILabel!
}
