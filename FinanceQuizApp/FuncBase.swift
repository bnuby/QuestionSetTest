//
//  FuncBase.swift
//  FinanceQuizApp
//
//  Created by Gibson Kong on 11/05/2017.
//  Copyright © 2017 訪客使用者. All rights reserved.
//

import Foundation
import UIKit

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
            temp.addLicenseGrade(LicenseGrade(data[j]["Grade"] as! String))
            
            // Get Profession_Type.data.ExamSet Such As ExamName
            let temp_LicenseSet = data[j]["LicenseSet"] as! [[String:Any]]
            for k in 0 ..< temp_LicenseSet.count{
                temp.LicenseGrade[j].addLicenseType(LicenseType(temp_LicenseSet[k]["LicenseType"] as! String))
                let temp_ExamSet = temp_LicenseSet[k]["ExamSet"] as! [[String:Any]]
                for l in 0 ..< temp_ExamSet.count{
                    let temp_ExamSetContent = temp_ExamSet[l] as! [String:String]
                    temp.LicenseGrade[j].LicenseType[k].addExamSet(ExamSet(id: l, name: temp_ExamSetContent["name"]!, LicenseDir: temp_ExamSetContent["LicenseDir"]!, Filename: temp_ExamSetContent["Filename"]!))
                    //                    (quizSet(id: k, name: ExamSet[k]["LicenseType"]! as! String))
                    if temp_ExamSetContent["Filename"] != "" {
                        if let file = Bundle.main.url(forResource: temp_ExamSetContent["Filename"]!, withExtension: "json", subdirectory: temp_ExamSetContent["LicenseDir"]!){
                            
                            let data2 = try! Data(contentsOf: file)
                            let json = try! JSONSerialization.jsonObject(with: data2, options: []) as! [String:Any]
                            
                            temp.LicenseGrade[j].LicenseType[k].ExamSet[l].name = json["quizSetName"]! as! String
                            var QuizList = json["quiz"] as! [[String:Any]]
                            for m in 0 ..< QuizList.count {
                                temp.LicenseGrade[j].LicenseType[k].ExamSet[l].addQuiz(quiz(id: m, question: QuizList[m]["question"]! as! String, choice: QuizList[m]["choice"]! as! [String], answer: QuizList[m]["answer"]! as! [String]))
                            }                            
                        }
                    }
                    
//                    if let QuizSet = ExamSet[k]["QuizSet"] as? [[String:Any]]{
//                        for l in 0..<QuizSet.count{
//                            let answer = QuizSet[l]["answer"] as! [String]
//                            let choice = QuizSet[l]["choice"] as! [String]
//                            temp.ExamSet[j].QuizSet[k].addQuiz(quiz(id: l, question: QuizSet[l]["question"] as! String, choice: choice, answer: answer))
//                            
//                        }
//                    }
                }
                
                
            }
        }
        
        ProfessionSet.append(temp)
    }
}

func shuffle (_ a : quiz) -> [String]{
    var string : [String] = []
//    for i in a.answer {
//        string.append(i)
//    }
    for i in a.choice {
        string.append(i)
    }
    for _ in 0..<string.count{
        var a = 0
        var b = 0
        while(a == b){
            a = Int(arc4random_uniform(UInt32(string.count)))
            b = Int(arc4random_uniform(UInt32(string.count)))
        }
        swap(&string[a], &string[b])
        
    }
    return string
}





class RadialGradientLayer: CALayer {
    
    var center: CGPoint {
        return CGPoint(x: bounds.width/2, y: bounds.height/2)
    }
    
    var radius: CGFloat {
        return (bounds.width + bounds.height)/2
    }
    
    var colors: [UIColor] = [UIColor.black, UIColor.lightGray] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var cgColors: [CGColor] {
        return colors.map({ (color) -> CGColor in
            return color.cgColor
        })
    }
    
    override init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
    }
    
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else {
            return
        }
        ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
    }
    
}

func collectionHeaderSize(_ lbl:UILabel){
    lbl.font.withSize(50)
    lbl.minimumScaleFactor = 0.5
    lbl.adjustsFontSizeToFitWidth = true
    lbl.numberOfLines = 20
    lbl.lineBreakMode = .byClipping
}

func collectionCellSize(text:UILabel,_ quiz:String ,_ collectionView:UICollectionView){
    text.frame.size = CGSize(width: collectionView.bounds.width - 60, height: 20)
    text.font.withSize(50)
    text.numberOfLines = 30
    text.lineBreakMode = .byClipping
    text.minimumScaleFactor = 0.5
    text.adjustsFontSizeToFitWidth = true
    text.text = quiz
    text.sizeToFit()
    if text.frame.height > 300{
        text.frame.size.height = 300
        text.sizeThatFits(CGSize(width: collectionView.bounds.width - 60, height: 300))
    } else if text.frame.height < 30{
        text.frame.size.height = 30
        text.sizeThatFits(CGSize(width: collectionView.bounds.width - 60, height: 30))
    }
}

class RadialGradientView: UIView {
    
    private let gradientLayer = RadialGradientLayer()
    
    var colors: [UIColor] {
        get {
            return gradientLayer.colors
        }
        set {
            gradientLayer.colors = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if gradientLayer.superlayer == nil {
            layer.insertSublayer(gradientLayer, at: 0)
        }
        gradientLayer.frame = bounds
    }
}

func collectionHeaderLayout(_ header : UICollectionReusableView) {
    header.layer.cornerRadius = header.frame.height * 0.25
    header.backgroundColor = UIColor.orange
    header.layer.borderWidth = 1
    header.layer.borderColor = UIColor.orange.cgColor
}

func collectionCellLayout(_ Cell : UICollectionViewCell) {
    Cell.layer.cornerRadius = Cell.frame.height / 2
    if Cell.layer.cornerRadius > 20{
        Cell.layer.cornerRadius = 20
    }
    Cell.layer.borderWidth  = 1
    Cell.layer.borderColor = UIColor.gray.cgColor
}

func ButtonAdjust(_ allbutton : [UIButton]){
    var min : CGFloat = 999.0
    for i in allbutton{
        i.titleLabel?.adjustsFontSizeToFitWidth = true
        i.titleLabel?.minimumScaleFactor = 0.3
        i.titleLabel?.lineBreakMode = .byClipping
        i.titleLabel?.numberOfLines = 1
        if (i.titleLabel?.font.pointSize)! < min{
            min = (i.titleLabel?.font.pointSize)!
        }
    }
    for i in allbutton{
        i.titleLabel?.font.withSize(min)
    }
}


extension Int16{
    func toInt() -> Int{
        return Int(self)
    }
}

extension UITableViewCell{
    func setGradiantLayer(_ color : [Any]){
        let gL = CAGradientLayer()
        gL.frame = self.bounds
        gL.colors = color
        self.layer.addSublayer(gL)
    }
}

