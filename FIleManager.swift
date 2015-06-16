//
//  FileManager.swift
//  Food Quiz
//
//  Created by Felipe de Lara on 2015-05-10.
//  Copyright (c) 2015 Felipe de Lara. All rights reserved.
//

import Foundation
import SwiftyJSON

func loadStringFromFile(fileName: String, fileExtention: String) -> String{
    let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtention)
    var content = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
    
    return content
}

func loadDataFromFile(fileName: String, fileExtention: String) -> NSData{
    
    let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtention)
    var data = NSData(contentsOfFile:path!)
    
    return data!
}

func loadJSONData(jsonData: NSData, content:String) -> JSON{
    
    var json = JSON(data: jsonData)
    
    json = json[content] // i.e. load objects, questions, etc.
    
    
    //    for (index: String, subJson: JSON) in json {
    //        //println(index)
    //    }
    
    return json
    
}