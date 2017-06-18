//
//  QuestionSet.swift
//  cloudkit
//
//  Created by Gibson Kong on 01/04/2017.
//  Copyright © 2017 Gibson Kong. All rights reserved.
//

import Foundation

class quiz{
    var id : Int!
    var question : String!
    var answer : [String]!
    var choice : [String]!
    init(id:Int,question:String,choice:[String],answer:[String]) {
        self.id = id
        self.question = question
        self.answer = answer
        self.choice = choice
    }
    func checkAns(){
        return
    }
    func start(){
        
    }
}


class ExamSet{
    var setID : Int!
    var name : String!
    var quizList = [quiz]()
    var LicenseDir : String!
    var Filename : String!

    init(id : Int, name : String, LicenseDir : String, Filename : String) {
        self.setID = id
        self.name = name
        self.LicenseDir = LicenseDir
        self.Filename = Filename
    }
    func addQuiz(_ element:quiz){
        quizList.append(element)
    }
    func selectQuiz(_ id:Int) -> quiz {
        return quizList[(id - 1)]
    }
    func demoQuizInit(){
        for i in 1...20 {
            var asd:[String] = []
            for j in 1...10 {
                asd.append("\(i * j * 2)")
            }
            let _quiz = quiz(id: i, question: "number \(i)", choice: asd, answer: ["0"] )
            self.addQuiz(_quiz)
        }
        for _quiz in quizList {
            print("\(_quiz.choice)  \(_quiz.answer)  \(_quiz.question)")
        }
    }
    func shuffle(){
        for _ in 0..<quizList.count{
            var a = 0
            var b = 0
            while(a == b){
                a = Int(arc4random_uniform(UInt32(quizList.count)))
                b = Int(arc4random_uniform(UInt32(quizList.count)))
            }
            swap(&quizList[a], &quizList[b])
            
        }
    }
    
    func clone() -> ExamSet{
        let temp = ExamSet(id: self.setID, name: self.name, LicenseDir: self.LicenseDir, Filename: self.Filename)
        for i in self.quizList{
            temp.quizList.append(i)
        }
        return temp
    }
}

class LicenseType {
    var LicenseName:String!
    var ExamSet : [ExamSet] = []
    
    init(_ LicenseName:String){
        self.LicenseName = LicenseName
    }
    
    func addExamSet(_ Set:ExamSet)  {
        self.ExamSet.append(Set)
    }
}


class LicenseGrade{
    var Grade : String!
    var LicenseType : [LicenseType] = []
    
    init(_ QuizGrade :String) {
        self.Grade = QuizGrade
    }
    
    func addLicenseType(_ Type:LicenseType){
            LicenseType.append(Type)
    }
    
}


class professionType{
    var ProfessionName : String!
    var LicenseGrade : [LicenseGrade] = []
    init(Name : String) {
        self.ProfessionName = Name
    }
    func addLicenseGrade(_ LicenseGrade:LicenseGrade){
        self.LicenseGrade.append(LicenseGrade)
    }
    
}



