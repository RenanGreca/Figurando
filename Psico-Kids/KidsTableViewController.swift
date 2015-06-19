//
//  KidsTableViewController.swift
//  Psico-Kids
//
//  Created by Samuel Lucas Ribeiro Cortez on 15/06/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit
import Foundation


var kidsList: Array = Array <AnyObject>()
var orderedkidsList: NSMutableArray = NSMutableArray()

var selectedIndexPath = NSIndexPath()
var isItEditing = Bool()


class KidsTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var kidsTableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        isItEditing = false
        readAllDataFromFiles()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kidsTableView.delegate = self
        kidsTableView.dataSource = self
        
        readAllDataFromFiles()
        
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if orderedkidsList[section].count != 0{
            return ((toString(orderedkidsList[section][0][0]) as NSString).substringToIndex(1)).uppercaseString
        }else{
            return ""
        }
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        var indexTitles = Array<AnyObject>()
        
        // Indice com todo o alfabeto
        indexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        // Indice apenas com secoes preenchidas
        
        //        for item in orderedkidsList{
        //            if item.count != 0{
        //                indexTitles.append(((toString(item[0][0]) as NSString).substringToIndex(1)).uppercaseString)
        //            }
        //        }
        
        return indexTitles
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return orderedkidsList.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return orderedkidsList[section].count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("kidCell", forIndexPath: indexPath) as! KidTableViewCell
        
        cell.kidsName?.text = (orderedkidsList[indexPath.section][indexPath.row][0] as! String)
        cell.kidsAge?.text = (orderedkidsList[indexPath.section][indexPath.row][1] as! String).stringByAppendingString(" anos")
        cell.parentsContact?.text = (orderedkidsList[indexPath.section][indexPath.row][5] as! String)
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
        var filePath = documentsPath[0]
        filePath = filePath.stringByAppendingString("/" + (orderedkidsList[indexPath.section][indexPath.row][0] as! String) + (orderedkidsList[indexPath.section][indexPath.row][5] as! String) + ".png")
        
        cell.profilePic.image = UIImage(contentsOfFile: filePath)
        
        cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width / 2;
        cell.profilePic.clipsToBounds = true;
        
        cell.profilePic.layer.borderWidth = 3.0
        cell.profilePic.layer.borderColor = UIColor.blackColor().CGColor
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            orderedkidsList[indexPath.section].removeObjectAtIndex(indexPath.row)
            
            
            
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            updateCVSData()
            
            tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}

func updateCVSData () {
    
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
    var filePath = documentsPath[0]
    filePath = filePath.stringByAppendingString("/KidsList.csv")
    
    
    var wholeData = String()
    kidsList.removeAll(keepCapacity: true)
    
    for items in orderedkidsList{
        kidsList.append(items)
    }
    
    
    for kids in kidsList{
        if kids.count > 0{
            wholeData = wholeData.stringByAppendingString((kids[0][0] as! String) + ";")
            wholeData = wholeData.stringByAppendingString((kids[0][1] as! String) + ";")
            wholeData = wholeData.stringByAppendingString((kids[0][2] as! String) + ";")
            wholeData = wholeData.stringByAppendingString((kids[0][3] as! String) + ";")
            wholeData = wholeData.stringByAppendingString((kids[0][4] as! String) + ";")
            wholeData = wholeData.stringByAppendingString((kids[0][5] as! String) + "$")
        }
    }
    wholeData.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
}

func readAllDataFromFiles (){
    
    kidsList.removeAll(keepCapacity: true)
    orderedkidsList.removeAllObjects()
    
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
    var filePath = documentsPath[0]
    filePath = filePath.stringByAppendingString("/KidsList.csv")
    
    var dataFromFile = String()
    
    if !(NSFileManager.defaultManager().fileExistsAtPath(filePath)) {
        NSFileManager.defaultManager().createFileAtPath(filePath, contents: nil, attributes: nil)
        let initialValues = ""
        initialValues.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
    }else{
        dataFromFile = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil)!
    }
    
    
    
    
    var arrayOfEverything: NSArray = dataFromFile.componentsSeparatedByString("$")
    for item in arrayOfEverything{
        kidsList.append((item as! String).componentsSeparatedByString(";"))
    }
    
    
    kidsList.removeLast()
    
    orderedkidsList = [ orderByLetter("A"),
        orderByLetter("B"),
        orderByLetter("C"),
        orderByLetter("D"),
        orderByLetter("E"),
        orderByLetter("F"),
        orderByLetter("G"),
        orderByLetter("H"),
        orderByLetter("I"),
        orderByLetter("J"),
        orderByLetter("K"),
        orderByLetter("L"),
        orderByLetter("M"),
        orderByLetter("N"),
        orderByLetter("O"),
        orderByLetter("P"),
        orderByLetter("Q"),
        orderByLetter("R"),
        orderByLetter("S"),
        orderByLetter("T"),
        orderByLetter("U"),
        orderByLetter("V"),
        orderByLetter("W"),
        orderByLetter("X"),
        orderByLetter("Y"),
        orderByLetter("Z")]
}





func orderByLetter (Letter: String) -> NSMutableArray{
    var itemsPerSection = NSMutableArray()
    for item in kidsList{
        if (((toString(item[0]) as NSString).substringToIndex(1)).uppercaseString as NSString).isEqualToString(Letter){
            itemsPerSection.addObject(item)
        }
        
        
    }
    return itemsPerSection
}