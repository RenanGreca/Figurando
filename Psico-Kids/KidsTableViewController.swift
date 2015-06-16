//
//  KidsTableViewController.swift
//  Psico-Kids
//
//  Created by Samuel Lucas Ribeiro Cortez on 15/06/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit

var kidsList: Array = Array <AnyObject>()

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
        
        var orderedkidsList = [AnyObject].self
        for item in kidsList{
            
        }
        
        
    }
    
    func orderByLetter (Letter: String){
        for item in kidsList{
            
                
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return kidsList.count-1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return kidsList[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("kidCell", forIndexPath: indexPath) as! KidTableViewCell

        cell.kidsName?.text = (kidsList[indexPath.section][1] as! String)
        cell.kidsAge?.text = (kidsList[indexPath.section][2] as! String).stringByAppendingString(" anos")
        cell.parentsContact?.text = (kidsList[indexPath.section][6] as! String)
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
        var filePath = documentsPath[0]
        filePath = filePath.stringByAppendingString("/" + (kidsList[indexPath.section][1] as! String) + (kidsList[indexPath.section][6] as! String) + ".png")

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
