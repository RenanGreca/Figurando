//
//  Question.swift
//  Psico-Kids
//
//  Created by Felipe Ramon de Lara on 6/19/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import Foundation

class QuestionRecord{
        
    var objectToIdentify: String
    var questionType: Int
    var option1: String
    var option2: String
    var option3: String
    var selectedOption: Int
    var elapsedTimeInSeconds: Int
 
    
    init (objectToIdentify: String, option1: String, option2: String, option3: String, selectedOption: Int, elapsedTimeInSeconds: Int, questionType: Int){
        self.elapsedTimeInSeconds = elapsedTimeInSeconds
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.objectToIdentify = objectToIdentify
        self.selectedOption = selectedOption
        self.questionType = questionType
    }
    
    func writeToCSV(fileName: String) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
        let filePath = "\(documentsPath[0])/\(fileName).csv"
        
        if isItEditing {
            updateCVSData()
            readAllDataFromFiles()
        }
        
        var newProfile = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil)

        if (newProfile != nil) {
            newProfile! += "\(self.elapsedTimeInSeconds);\(self.option1);\(self.option2);\(self.option3);\(self.objectToIdentify);\(self.questionType);$"
        } else {
            newProfile = "\(self.elapsedTimeInSeconds);\(self.option1);\(self.option2);\(self.option3);\(self.objectToIdentify);\(self.questionType);$"
        }
        
        newProfile!.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding, error: nil)

    }
    
    static func readFromCSV(fileName: String)->(Array<Float>, Array<Int>) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
        let filePath = "\(documentsPath[0])/\(fileName).csv"
        
        if isItEditing {
            updateCVSData()
            readAllDataFromFiles()
        }
        
        //var avg1, avg2, avg3, avg4: Float
        var avg:Array<Float> = []
        var count:Array<Int> = []
        for i in 0..<QuestionTypes.count {
            avg.append(0.0)
            count.append(0)
        }
        
        if let newProfile = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil) {
            let arrayOfTests:Array<String> = newProfile.componentsSeparatedByString("$")
            for a in arrayOfTests {
                var arrayOfItems = a.componentsSeparatedByString(";")
                if arrayOfItems.count >= 5 {
                    if let type = arrayOfItems[5].toInt() {
                        avg[type] += Float(arrayOfItems[0].toInt()!)
                        count[type]++
                    }
                }
            }
        }
        
        for i in 0..<QuestionTypes.count {
            if (count[i] > 0) {
                avg[i] = avg[i] / Float(count[i])
            }
        }
        
        return (avg, count)
    }
    
}

