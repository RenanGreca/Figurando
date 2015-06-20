//
//  ObjectList.swift
//  Alfabetizacao
//
//  Created by Renan Greca on 6/15/15.
//  Copyright © 2015 renangreca. All rights reserved.
//

import Foundation
import SwiftyJSON


class ObjectList {
    var _objects: Array<Object> = []
    
    struct Static {
        static let instance = ObjectList()
    }

    func populate() -> Bool {
    
        var error:NSErrorPointer = NSErrorPointer();
        
        let path = NSBundle.mainBundle().pathForResource("objects", ofType: "json")
        
        if let data = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: error) {
            println(error)
            let json = JSON(data: data)
            
            if let objects = json["objects"].arrayValue as? Array {
                
                for name in objects {
                    let o = Object(name: name.stringValue)
                    _objects.append(o)
                }
                
            }
        }
        
        return (_objects.count > 0)
    }
    
    func getRandomObjects(count: Int) -> Array<Object> {
        if count > _objects.count {
            return _objects
        }
        
        var objects = Array<Object>()
        var object: Object
        var random: Bool
        var r: Int
        
        for(var i=0; i<count; i++) {
            // Repeat while the random element is already in the random list
            do {
                random = true
                r = Int(arc4random_uniform(UInt32(_objects.count)))
                object = _objects[r]
                
                for obj in objects {
                    if obj.name == object.name {
                        random = false
                    }
                }
            } while (!random)
            objects.append(object)
        }
        
        return objects
    }
}