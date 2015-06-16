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
var orderedkidsList: Array = Array<AnyObject>()

class KidsTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var kidsTableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kidsTableView.delegate = self
        kidsTableView.dataSource = self
        

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
        
        orderedkidsList = [   orderByLetter("A"), orderByLetter("B"), orderByLetter("C"), orderByLetter("D"),
            orderByLetter("E"), orderByLetter("F"), orderByLetter("G"), orderByLetter("H"), orderByLetter("I"), orderByLetter("J"),
            orderByLetter("K"), orderByLetter("L"), orderByLetter("M"), orderByLetter("N"), orderByLetter("O"), orderByLetter("P"),
            orderByLetter("Q"), orderByLetter("R"), orderByLetter("S"), orderByLetter("T"), orderByLetter("U"), orderByLetter("V"),
            orderByLetter("W"), orderByLetter("X"), orderByLetter("Y"), orderByLetter("Z")]
        
        
        print(orderedkidsList)
    }
    
    func orderByLetter (Letter: String) -> Array<AnyObject>{
        var itemsPerSection = Array<AnyObject>()
        for item in kidsList{
            if (((toString(item[0]) as NSString).substringToIndex(1)).uppercaseString as NSString).isEqualToString(Letter){
                itemsPerSection.append(item)
            }
                
            
        }
        return itemsPerSection
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        
//    }

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
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
