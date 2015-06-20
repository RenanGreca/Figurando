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
        self.option3 = option2
        self.objectToIdentify = objectToIdentify
        self.selectedOption = selectedOption
        self.questionType = questionType
    }
    
}

