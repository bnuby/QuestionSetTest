//
//  DoingEverWrongQuizViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 14/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit

class DoingEverWrongQuizViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    var getQuiz : quiz!
    var quiz : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        for i in getQuiz.answer{
            quiz.append(i)
        }
        for i in getQuiz.choice{
            quiz.append(i)
        }
        return (getQuiz.answer.count + getQuiz.choice.count)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: view.bounds.width - 50, height: 20)
        
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = quiz[indexPath.row]
        lbl.sizeToFit()
        
        return CGSize(width: view.frame.width - 20, height: lbl.frame.height + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: view.bounds.width - 50, height: 20)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = getQuiz.question
        print(lbl.frame.height)
        lbl.sizeToFit()
        print(lbl.frame.height)
        
        return CGSize(width: view.bounds.width - 50, height: lbl.bounds.height + 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if getQuiz.answer.contains(quiz[indexPath.row]){
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.green
        } else {
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.red
            collectionView.cellForItem(at: IndexPath(row: quiz.index(of: getQuiz.answer[0])!, section: 0))?.backgroundColor = UIColor.green
            
        }
    }
    
    
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
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let Header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! DoingQuizCollectionHeader
        Header.backgroundColor = UIColor.orange
        Header.layer.borderWidth = 1
        Header.layer.borderColor = UIColor.orange.cgColor
        Header.Headerlbl.text = getQuiz.question
        
        return Header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DoingQuizColllectionCell
        Cell.layer.borderWidth  = 1
        Cell.layer.borderColor = UIColor.gray.cgColor
        Cell.Quizlbl.text = quiz[indexPath.row]
        
        return Cell
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

class DoingEverWrongQuizHeader : DoingQuizCollectionHeader {
}

class DOingEverWrongQuizCell : DoingQuizColllectionCell {
    
}
