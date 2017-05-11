//
//  FuncBase.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 11/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import Foundation

var ProfessionSet : [professionType] = []

func readJson( _ jsonFileName : String = "FinanceQuizApp") {
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

func dataProcess(object : [String: Any] ){
    
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
                        temp.ExamSet[j].QuizSet[k].addQuiz(quiz(id: l, question: QuizSet[l]["question"] as! String, choice: choice, answer: answer))
                        
                    }
                }
                
            }
        }
        
        ProfessionSet.append(temp)
    }
}
