//
//  KidProfileViewController.swift
//  Psico-Kids
//
//  Created by Samuel Lucas Ribeiro Cortez on 16/06/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit

class KidProfileViewController: UIViewController{

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameOfKid: UILabel!
    @IBOutlet weak var ageAndGenderOfKid: UILabel!
    @IBOutlet weak var contactOfKid: UILabel!
    @IBOutlet weak var parentsOfKid: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        isItEditing = true
        
        
        readAllDataFromFiles()
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
        var filePath = documentsPath[0]
        
        print(orderedkidsList)
        filePath = filePath.stringByAppendingString("/" + (orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][0] as! String) + (orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][5] as! String) + ".png")
        
        
        nameOfKid.text = orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][0] as? String
        ageAndGenderOfKid.text = (orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][1] as? String)! + " anos - "
            + (orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][2] as? String)!
        
        parentsOfKid.text = "Cuidadores: " +
            (orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][3] as? String)! + " e " +
            (orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][4] as? String)!
        
        contactOfKid.text = "Telefone: " + (orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][5] as? String)!
        
        profileImage.image = UIImage(contentsOfFile: filePath)
        backgroundImage.image =  UIImage(contentsOfFile: filePath)
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2;
        profileImage.clipsToBounds = true;
        
        profileImage.layer.borderWidth = 3.0
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    
    

}
