//
//  ViewController.swift
//  Psico-Kids
//
//  Created by Samuel Lucas Ribeiro Cortez on 15/06/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var btnJogar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnJogar.titleLabel!.font = UIFont(name: "ChubbyCheeks", size: 34)!
        
        //self.navigationController?.navigationBar.titleTextAttributes = attributes
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

