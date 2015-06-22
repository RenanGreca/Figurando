//
//  Child.swift
//  Psico-Kids
//
//  Created by Renan Greca on 6/22/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import Foundation

class Child: NSObject {
    
    enum Sex {
        case male, female
    }
    
    var name: String
    var age: Int
    var gender: Sex
    var fathersName: String
    var mothersName: String
    var parentsNumber: String
    
    init (name: String, age: Int, gender: Sex, fathersName: String, mothersName: String, parentsNumber: String) {
        self.name = name
        self.age = age
        self.gender = gender
        self.fathersName = fathersName
        self.mothersName = mothersName
        self.parentsNumber = parentsNumber
    }
}
