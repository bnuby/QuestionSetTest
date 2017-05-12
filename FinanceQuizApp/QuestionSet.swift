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


class quizSet{
    var setID : Int!
    var name : String!
    var quizList = [quiz]()
    init(id:Int,name:String) {
        self.setID = id
        self.name = name
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
    
    func clone() -> quizSet{
        let temp = quizSet(id: self.setID, name: self.name)
        for i in self.quizList{
            temp.quizList.append(i)
        }
        return temp
    }
}

class examSet{
    var QuizGrade : String!
    var QuizSet : [quizSet] = []
    
    init(_ QuizGrade :String) {
        self.QuizGrade = QuizGrade
    }
    
    func addQuizSet(_ Set:quizSet)  {
        self.QuizSet.append(Set)
    }
}

class professionType{
    var ProfessionName : String!
    var ExamSet : [examSet] = []
    init(Name : String) {
        self.ProfessionName = Name
    }
    func addExamSet(_ ExamSet:examSet){
        self.ExamSet.append(ExamSet)
    }
    
}



