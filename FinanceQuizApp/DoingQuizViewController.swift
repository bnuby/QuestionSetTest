//
//  DoingQuizViewController.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 06/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import UIKit
import CoreData

class DoingQuizViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout  {
    
    var markedquiz = [MarkedQuiz]()
    var ExamSet : ExamSet?
    var QuizDetail : [String:Int] = ["ProfessionSet":0,"LicenseGrade":0,"LicenseType":0,"ExamSet":0]
    var scoreDetails : [String:Int] = ["totalScore" : 0 , "scorePerQuiz" : 0, "Correct" : 0]
    var EazierWrongSet : [TheEazierWrongQuiz]!
    var EverWrongQuizSet : [EverWrongQuiz]!
    var quiz : [String]!
    var numberOfQuiz = 0
    @IBOutlet var markedButton: UIButton!
    @IBOutlet var QuestionNextBtn: UIButton!
    @IBOutlet var QuizCollectionView: UICollectionView!
    @IBAction func QuestionBtn(_ sender: Any) {
        QuestionNextBtn.isEnabled = false
        if QuestionNextBtn.titleLabel?.text == "Check" {
            if var SelectedIndex = QuizCollectionView.indexPathsForSelectedItems?.first {
                let cell = (QuizCollectionView.cellForItem(at: SelectedIndex) as! DoingQuizColllectionCell)
                
                if cell.Quizlbl.text == ExamSet?.quizList[numberOfQuiz].answer[0]{
                    QuizCollectionView.cellForItem(at: SelectedIndex)?.backgroundColor = UIColor.green
                    
                    
                    scoreDetails["Correct"]! += 1
                    scoreDetails["totalScore"]! += scoreDetails["scorePerQuiz"]!
                    print(scoreDetails["Correct"]!)
                    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                        
                        
                        EazierWrongSet.filter({ (a) -> Bool in
                            if a.examSet == Int16(QuizDetail["ExamSet"]!) && a.licenseGrade == Int16(QuizDetail["LicenseGrade"]!) && a.licenseType == Int16(QuizDetail["LicenseType"]!) && a.quizID == Int16(ExamSet!.quizList[numberOfQuiz].id) && a.professionSet == Int16(QuizDetail["ProfessionSet"]!){
                                //                                    print("hello",a.count,EazierWrongSet.index(of: a)!)
                                if a.count <= 1 {
                                    EazierWrongSet.remove(at: EazierWrongSet.index(of: a)!)
                                    context.delete(a)
                                }else{
                                    a.setValue(Int(a.value(forKey: "count") as! Int16)-1, forKey: "count")
                                    
                                }
                                do{
                                    try context.save()
                                } catch let error as NSError{
                                    print("error : \(error)")
                                }
                                return true
                            }
                            return false
                            }
                        )
                        
                    }
                } else {
                    QuizCollectionView.cellForItem(at: SelectedIndex)?.backgroundColor = UIColor.red
                    QuizCollectionView.cellForItem(at: IndexPath(row: quiz.index(of: (ExamSet?.quizList[numberOfQuiz].answer[0])!)!
                        , section: 0))?.backgroundColor = UIColor.green
                    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                        
                        
                        var check = false
                        
                        EazierWrongSet.filter({ (a) -> Bool in
                            if a.examSet == Int16(QuizDetail["ExamSet"]!) && a.licenseGrade == Int16(QuizDetail["LicenseGrade"]!) && a.licenseType == Int16(QuizDetail["LicenseType"]!) && a.quizID == Int16(ExamSet!.quizList[numberOfQuiz].id) && a.professionSet == Int16(QuizDetail["ProfessionSet"]!) {
                                //                                    var tempContext = context
                                //                                    let temp = a
                                check = true
                                a.setValue(Int(a.value(forKey: "count") as! Int16)+1, forKey: "count")
                                
                                do{
                                    try context.save()
                                } catch let error as NSError{
                                    print("error : \(error)")
                                }
                                return true
                            }
                            
                            return false
                            }
                        )
                        
                        if !check{
                            let data = NSEntityDescription.insertNewObject(forEntityName: "TheEazierWrongQuiz", into: context) as! TheEazierWrongQuiz
                            data.setValue(ExamSet?.quizList[numberOfQuiz].id, forKey: "quizID")
                            data.setValue(QuizDetail["LicenseGrade"]!, forKey: "licenseGrade")
                            data.setValue(QuizDetail["LicenseType"]!, forKey: "licenseType")
                            data.setValue(QuizDetail["ExamSet"]!, forKey: "examSet")
                            print(QuizDetail["ProfessionSet"]!)
                            data.setValue(QuizDetail["ProfessionSet"]!, forKey: "professionSet")
                            data.setValue(1, forKey: "count")
                            
                            do{
                                try context.save()
                            } catch let error as NSError{
                                print("error : \(error)")
                            }
                        }
                        
                        check = false
                        
                        EverWrongQuizSet.contains(where: { (a) -> Bool in
                            check = false
                            print("here")
                            if a.examSet == Int16(QuizDetail["ExamSet"]!) && a.licenseGrade == Int16(QuizDetail["LicenseGrade"]!) && a.licenseType == Int16(QuizDetail["LicenseType"]!) && a.quizID == Int16(ExamSet!.quizList[numberOfQuiz].id) && a.professionSet == Int16(QuizDetail["ProfessionSet"]!) {
                                //                                    var tempContext = context
                                //                                    let temp = a
                                check = true
                                
                                return true
                            }
                            return false
                        })
                        print(check)
                        if !check{
                            print("here")
                            let data = NSEntityDescription.insertNewObject(forEntityName: "EverWrongQuiz", into: context) as! EverWrongQuiz
                            data.setValue(ExamSet?.quizList[numberOfQuiz].id, forKey: "quizID")
                            data.setValue(QuizDetail["LicenseGrade"], forKey: "licenseGrade")
                            data.setValue(QuizDetail["LicenseType"], forKey: "LicenseType")
                            data.setValue(QuizDetail["ExamSet"], forKey: "examSet")
                            data.setValue(QuizDetail["ProfessionSet"], forKey: "professionSet")
                            do{
                                try context.save()
                            } catch let error as NSError{
                                print("error : \(error)")
                            }
                        }
                        
                    }
                    
                }
                if numberOfQuiz + 1 == ExamSet?.quizList.count{
                    QuestionNextBtn.setTitle("Finished", for: .normal)
                    QuestionNextBtn.titleLabel?.text = "Finished"
                    
                }else{
                    QuestionNextBtn.setTitle("Next", for: .normal)
                    QuestionNextBtn.titleLabel?.text = "Next"
                    
                    
                }
                numberOfQuiz += 1
                QuestionNextBtn.isEnabled = true
                
                QuestionNextBtn.sizeToFit()
            }
            
            
        } else if QuestionNextBtn.titleLabel?.text == "Finished" {
            resetall()
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (true) in
                self.performSegue(withIdentifier: "UnwindToQuizSetView", sender: self)
            })
            let alertController = { () -> UIAlertController in
                let temp = UIAlertController(title: "Finished", message: "You had Correct \(self.scoreDetails["Correct"]!) in \(self.ExamSet!.quizList.count) .\nYour Score is \(self.scoreDetails["totalScore"]!).", preferredStyle: .alert)
                temp.addAction(alertAction)
                return temp
            }
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                
                let data = NSEntityDescription.insertNewObject(forEntityName: "History", into: context)
                data.setValue(Int16(QuizDetail["ProfessionSet"]!) , forKey: "professionSet")
                data.setValue(Int16(QuizDetail["LicenseGrade"]!) , forKey: "licenseGrade")
                data.setValue(Int16(QuizDetail["LicenseType"]!) , forKey: "licenseType")
                data.setValue(Int16(QuizDetail["ExamSet"]!) , forKey: "examSet")
                
                data.setValue(scoreDetails["Correct"], forKey: "numberOfCorrect")
                data.setValue(scoreDetails["totalScore"], forKey: "score")
                
                do{
                    try context.save()
                } catch let error as NSError{
                    print("Save Failed Error = \(error)")
                }
                
            }
            
            present(alertController(), animated: true, completion: nil)
            
            
        } else {
            resetall()
            quiz = shuffle((ExamSet?.quizList[numberOfQuiz])!)
            QuizCollectionView.reloadData()
            if Markedchecker() {
                markedButton.backgroundColor = UIColor.blue
                markedButton.setTitle("✓", for: .normal)
                markedButton.titleLabel?.text = "✓"
                
            }else{
                markedButton.backgroundColor = UIColor.clear
                markedButton.setTitle("", for: .normal)
                markedButton.titleLabel?.text = ""
                
            }
            
        }
        //        QuestionNextBtn.isEnabled = true
        
    }
    
    @IBAction func markedBtn(_ sender: UIButton) {
        
        
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if sender.titleLabel?.text == "✓"{
                
                print("true")
                MarkedUncheck(context: context)
                markedButton.backgroundColor = UIColor.clear
                sender.titleLabel?.text = ""
                sender.setTitle("", for: .normal)
                return
            }
            
            print("false")
            let markedQuiz = NSEntityDescription.insertNewObject(forEntityName: "MarkedQuiz", into: context) as! MarkedQuiz
            markedQuiz.setValue(ExamSet?.quizList[numberOfQuiz].id, forKey: "quizID")
            markedQuiz.setValue(QuizDetail["ProfessionSet"], forKey: "professionSet")
            markedQuiz.setValue(QuizDetail["LicenseType"], forKey: "licenseType")
            markedQuiz.setValue(QuizDetail["LicenseGrade"], forKey: "licenseGrade")
            markedQuiz.setValue(QuizDetail["ExamSet"], forKey: "examSet")
            markedquiz.append(markedQuiz)
            //            markedquiz.sort(by: { (a, b) -> Bool in
            //                return a.professionSet < a.professionSet
            //            })
            do{
                try context.save()
                markedButton.backgroundColor = UIColor.blue
                sender.setTitle("✓", for: .normal)
                
            } catch let error as NSError{
                print("Save Failed Error = \(error)")
            }
            
        }
        
        //        if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
        //            let insert = NSEntityDescription.insertNewObject(forEntityName: "MarkedQuiz", into: managedContext) as! MarkedQuiz
        //            insert.setValue("", forKey: "")
        //        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        markedButton.layer.borderWidth = 1
        markedButton.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
    }
    
    func MarkedUncheck(context : NSManagedObjectContext){
        for i in 0..<markedquiz.count{
            if markedquiz[i].quizID == Int16((ExamSet?.quizList[numberOfQuiz].id)!) && markedquiz[i].examSet == Int16(QuizDetail["ExamSet"]!) && markedquiz[i].licenseType == Int16(QuizDetail["LicenseType"]!) && markedquiz[i].licenseGrade == Int16(QuizDetail["LicenseType"]!) && markedquiz[i].professionSet == Int16(QuizDetail["ProfessionSet"]!) {
                context.delete(markedquiz[i])
                markedquiz.remove(at: i)
                return
            }
        }
    }
    
    func Markedchecker() -> Bool{
        for i in 0..<markedquiz.count{
            if markedquiz[i].quizID == Int16((ExamSet?.quizList[numberOfQuiz].id)!) && markedquiz[i].examSet == Int16(QuizDetail["ExamSet"]!) && markedquiz[i].licenseType == Int16(QuizDetail["LicenseType"]!) && markedquiz[i].licenseGrade == Int16(QuizDetail["LicenseGrade"]!) && markedquiz[i].professionSet == Int16(QuizDetail["ProfessionSet"]!) {
                return true
            }
        }
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scoreDetails["scorePerQuiz"] =  100 / (ExamSet?.quizList.count)!
        quiz = shuffle((ExamSet?.quizList[numberOfQuiz])!)
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MarkedQuiz")
            let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "EverWrongQuiz")
            let fetchRequest3 = NSFetchRequest<NSFetchRequestResult>(entityName: "TheEazierWrongQuiz")

            do{
                markedquiz = try context.fetch(fetchRequest) as! [MarkedQuiz]
                EverWrongQuizSet = try context.fetch(fetchRequest2) as! [EverWrongQuiz]
                EazierWrongSet = try context.fetch(fetchRequest3) as! [TheEazierWrongQuiz]

            } catch let error as NSError {
                print("data fetching fail error = \(error)")
            }
            
            
            if Markedchecker() {
                markedButton.backgroundColor = UIColor.blue
                markedButton.setTitle("✓", for: .normal)
                markedButton.titleLabel?.text = "✓"
                
            }else{
                markedButton.backgroundColor = UIColor.clear
                markedButton.setTitle("", for: .normal)
                markedButton.titleLabel?.text = ""
                
            }
            
            
            
        }
        if Markedchecker() {
            markedButton.backgroundColor = UIColor.blue
            markedButton.setTitle("✓", for: .normal)
        }else{
            markedButton.backgroundColor = UIColor.clear
            markedButton.setTitle("", for: .normal)
        }
        print(markedquiz)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if ExamSet?.quizList.count != 0{
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ((ExamSet?.quizList[numberOfQuiz].answer.count)! + (ExamSet?.quizList[numberOfQuiz].choice.count)!)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! DoingQuizCollectionHeader
        
        
        header.Headerlbl.text = ExamSet?.quizList[numberOfQuiz].question
        header.backgroundColor = UIColor.orange
        header.layer.borderWidth = 1
        header.layer.borderColor = UIColor.orange.cgColor
        print(header.Headerlbl.frame.size)
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DoingQuizColllectionCell
        
        cell.Quizlbl.numberOfLines = 0
        cell.Quizlbl.lineBreakMode = .byWordWrapping
        cell.Quizlbl.text = quiz[indexPath.row]
        
        cell.layer.borderWidth  = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.blue
        QuestionNextBtn.isEnabled = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.clear
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: view.bounds.width - 90, height: 20)
        
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        if ExamSet?.quizList[numberOfQuiz].question != nil{
            lbl.text = ExamSet?.quizList[numberOfQuiz].question
            
        }
        lbl.sizeToFit()
        print(lbl.frame.size)
        
        return CGSize(width: view.bounds.width - 50, height: lbl.frame.size.height + 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let text = UILabel()
        text.bounds.size.width = view.bounds.width - 60
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        text.text = quiz[indexPath.row]
        
        text.sizeToFit()
        return CGSize(width: view.bounds.width - 20 , height: text.frame.height + 20)
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
    
    func resetall(){
        QuestionNextBtn.isEnabled = false
        
        QuestionNextBtn.setTitle("Check", for: .normal)
        for i in 0..<QuizCollectionView.numberOfItems(inSection: 0){
            QuizCollectionView.cellForItem(at: IndexPath(row: i, section: 0))?.backgroundColor = .clear
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

class DoingQuizCollectionHeader : UICollectionReusableView{
    
    @IBOutlet var Headerlbl: UILabel!
    
    
}

class DoingQuizColllectionCell : UICollectionViewCell{
    
    @IBOutlet var Quizlbl: UILabel!
    
    
}
