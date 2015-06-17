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
    
    init(name: String, img: String, sound: String) {
        self.name = name
        self.img = NSBundle.mainBundle().pathForResource(img, ofType: "png")!
        self.sound = sound
    }
    
}
