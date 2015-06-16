//
//  QuizViewController.swift
//  Psico-Kids
//
//  Created by Felipe Ramon de Lara on 6/16/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit
import SwiftyJSON

class QuizViewController: UIViewController {

    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var option1ImageView: UIImageView!
    @IBOutlet weak var option1Label: UILabel!
    
    @IBOutlet weak var option2ImageView: UIImageView!
    @IBOutlet weak var option2Label: UILabel!
    
    @IBOutlet weak var option3ImageView: UIImageView!
    @IBOutlet weak var option3Label: UILabel!
    
    var questionsJSON: JSON = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionsJSON =  loadJSONData(loadDataFromFile("questions", "txt"), "objects")

        
        questionLabel.text = "aaaaaa"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
//        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
//        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}