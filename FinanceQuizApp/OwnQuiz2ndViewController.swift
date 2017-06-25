//
//  OwnQuiz2ndViewController.swift
//  FinanceQuizApp
//
//  Created by D0515211 on 2017/6/24.
//  Copyright © 2017年 訪客使用者. All rights reserved.
//

import UIKit

class OwnQuiz2ndViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var quiz : quiz!
    var choice : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        choice = shuffle(quiz)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return choice.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lbl = UILabel()
        
        collectionCellSize(text: lbl, choice[indexPath.row], collectionView)
        
        return CGSize(width: collectionView.bounds.width , height: lbl.frame.height + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: collectionView.bounds.width - 20, height: 20)
        collectionHeaderSize(lbl)
        lbl.text = quiz.question
        
        lbl.sizeToFit()
        if lbl.frame.height > 300 {
            lbl.frame.size.height = 300
            lbl.sizeThatFits(CGSize(width: collectionView.bounds.width - 20, height: 300))
        } else if lbl.frame.height < 30 {
            lbl.frame.size.height = 30
            lbl.sizeThatFits(CGSize(width: collectionView.bounds.width - 20, height: 30))
        }
        return CGSize(width: collectionView.bounds.width - 20, height: lbl.bounds.height + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! OwnQuiz2ReuseableCell
        header.Quizlbl.text = quiz.question
        collectionHeaderLayout(header)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OwnQuiz2CollectionCell
        cell.Quiztextlbl.text = choice[indexPath.row]
        collectionCellLayout(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if quiz.answer.contains(choice[indexPath.row]){
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.green
        } else {
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.red
            collectionView.cellForItem(at: IndexPath(row: choice.index(of: quiz.answer[0])!, section: 0))?.backgroundColor = UIColor.green
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



class OwnQuiz2CollectionCell : UICollectionViewCell{
    
    @IBOutlet var Quiztextlbl: UILabel!
    
    
}

class OwnQuiz2ReuseableCell : UICollectionReusableView{
    @IBOutlet var Quizlbl: UILabel!
    
}


