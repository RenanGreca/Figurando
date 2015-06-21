//
//  KidProfileViewController.swift
//  Psico-Kids
//
//  Created by Samuel Lucas Ribeiro Cortez on 16/06/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit
import MagicPie

class KidProfileViewController: UIViewController, UIGestureRecognizerDelegate{

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameOfKid: UILabel!
    @IBOutlet weak var ageAndGenderOfKid: UILabel!
    @IBOutlet weak var contactOfKid: UILabel!
    @IBOutlet weak var parentsOfKid: UILabel!
    
    @IBOutlet weak var viewGraph: UIView!
    
    let graph = PieLayer()
    var shouldMovePie = true

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: Selector("selectPie:"))
        tap.numberOfTapsRequired = 1
        viewGraph.addGestureRecognizer(tap)

        
        
        
        
        graph.frame = CGRectMake(30, 30, 400, 400)
        
       
        
        var elementOne = PieElement(value: 20, color: UIColor(red: 228/255, green: 241/255, blue: 254/255, alpha: 1))
        var elementTwo = PieElement(value: 20, color: UIColor(red: 197/255, green: 239/255, blue: 247/255, alpha: 1))
        var elementThree = PieElement(value: 20, color: UIColor(red: 107/255, green: 185/255, blue: 240/255, alpha: 1))
        
        elementOne.centrOffset += 2
        elementTwo.centrOffset += 2
        elementThree.centrOffset += 2
        
        graph.addValues([elementOne], animated: true)
        graph.addValues([elementTwo], animated: true)
        graph.addValues([elementThree], animated: true)
        
        viewGraph.layer.addSublayer(graph)

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
    
    func selectPie (tap : UIGestureRecognizer) {
        let pointOnGraph = tap.locationInView(self.viewGraph)
        let elementOfGraph = graph.pieElemInPoint(pointOnGraph)
        
        if (elementOfGraph != nil){
            if (elementOfGraph.centrOffset == 2 && shouldMovePie){
                PieElement.animateChanges{
                elementOfGraph.centrOffset += 20
                }
                shouldMovePie = false
                print(elementOfGraph)
                updatePieSliceInfo(pointOnGraph)
            }else{
                PieElement.animateChanges{
                    elementOfGraph.centrOffset -= 20
                }
                shouldMovePie = true
            }
        }
        
    }

    func updatePieSliceInfo (pieSlice: CGPoint) {
        var positionInArray = graph.pieElemInPoint(pieSlice)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    
    

}
