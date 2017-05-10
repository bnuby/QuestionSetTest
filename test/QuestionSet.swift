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
    init(id:Int,quiz:String,choice:[String],answer:[String]) {
        self.id = id
        self.question = quiz
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
            let _quiz = quiz(id: i, quiz: "number \(i)", choice: asd, answer: ["0"] )
            self.addQuiz(_quiz)
        }
        for _quiz in quizList {
            print("\(_quiz.choice)  \(_quiz.answer)  \(_quiz.question)")
        }
    }
}



