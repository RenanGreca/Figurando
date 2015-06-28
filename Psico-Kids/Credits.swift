//
//  Credits.swift
//  Psico-Kids
//
//  Created by Samuel Lucas Ribeiro Cortez on 28/06/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit

class Credits: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.titleTextAttributes = attributes
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImageView(frame: CGRectMake(10, 40, 250, 150))
        image.image = UIImage(named: "bepid.png")
        image.contentMode = UIViewContentMode.ScaleAspectFit
        
        let text = UILabel(frame: CGRectMake(10, 10, 260, 20))
        text.text = "App desenvolvido no BEPiD PUCPR"
        text.textColor = UIColor.grayColor()
        text.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        
        
        self.preferredContentSize.height = 320
        self.preferredContentSize.width = 340
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}