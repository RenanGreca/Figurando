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
    
    let name: String
    let age: String
    let gender: String
    let fathersName: String
    let mothersName: String
    let parentsNumber: String
    
    init (name: String, age: String, gender: String, fathersName: String, mothersName: String, parentsNumber: String) {
        self.name = name
        self.age = age
        self.gender = gender
        self.fathersName = fathersName
        self.mothersName = mothersName
        self.parentsNumber = parentsNumber
    }
    
    init (kid: AnyObject) {
        
        self.name = kid[0] as! String
        self.age = kid[1] as! String
        self.gender = kid[2] as! String
        self.fathersName = kid[3] as! String
        self.mothersName = kid[4] as! String
        self.parentsNumber = kid[5] as! String

    }
}
