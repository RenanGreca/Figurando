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
        if let data = NSData(contentsOfFile: "objects.json") {
            let json = JSON(data: data)
            
            if let objects = json["objects"].arrayValue as? Array {
                
                for object in objects {
                    let name = object["name"].stringValue as String
                    let img = object["img"].stringValue as String
                    let sound = object["sound"].stringValue as String
                    
                    _objects.append(Object(name: name, img: img, sound: sound))
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
            repeat {
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