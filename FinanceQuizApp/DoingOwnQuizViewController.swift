//
//  DoingOwnQuizViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 11/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class DoingOwnQuizViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var quiz : quiz!
    var String : [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        String = shuffle(quiz)
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (quiz.answer.count + quiz.choice.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: view.bounds.width - 50, height: 20)
        
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = String[indexPath.row]
        lbl.sizeToFit()
        
        return CGSize(width: view.frame.width - 20, height: lbl.frame.height + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: view.bounds.width - 50, height: 20)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = quiz.question
        lbl.sizeToFit()

        return CGSize(width: view.bounds.width - 50, height: lbl.bounds.height + 30)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OwnQuizCollectionCell
        Cell.Quiztextlbl.numberOfLines = 0
        Cell.Quiztextlbl.lineBreakMode = .byWordWrapping
        Cell.Quiztextlbl.text = String[indexPath.row]
        Cell.layer.cornerRadius = Cell.frame.height * 0.5
        Cell.layer.borderWidth  = 1
        Cell.layer.borderColor = UIColor.gray.cgColor
        
        return Cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! OwnQuizReuseableCell
        header.Quizlbl.numberOfLines = 0
        header.Quizlbl.lineBreakMode = .byWordWrapping
        header.Quizlbl.text = quiz.question
        header.layer.cornerRadius = header.frame.height * 0.25
        header.backgroundColor = UIColor.orange
        header.layer.borderWidth = 1
        header.layer.borderColor = UIColor.orange.cgColor
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if quiz.answer.contains(String[indexPath.row]){
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.green
        } else {
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.red
            collectionView.cellForItem(at: IndexPath(row: String.index(of: quiz.answer[0])!, section: 0))?.backgroundColor = UIColor.green
            
        }    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.clear
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


class OwnQuizCollectionCell : UICollectionViewCell{
    
    @IBOutlet var Quiztextlbl: UILabel!
    
    
}

class OwnQuizReuseableCell : UICollectionReusableView{
    @IBOutlet var Quizlbl: UILabel!
    
}
