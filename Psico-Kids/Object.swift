//
//  Object.swift
//  Alfabetizacao
//
//  Created by Renan Greca on 6/15/15.
//  Copyright © 2015 renangreca. All rights reserved.
//
import Foundation

class Object {
    var name: String
    var img: String
    var sound: String
    
    init(name: String) {
        self.name = name
        self.img = NSBundle.mainBundle().pathForResource(name, ofType: "png")!
        self.sound = ""// NSBundle.mainBundle().pathForResource(name, ofType: "mp3")!
    }
    
}
