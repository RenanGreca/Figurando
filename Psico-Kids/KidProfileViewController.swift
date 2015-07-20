//
//  KidProfileViewController.swift
//  Psico-Kids
//
//  Created by Samuel Lucas Ribeiro Cortez on 16/06/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit

import PNChart

class KidProfileViewController: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameOfKid: UILabel!
    @IBOutlet weak var ageAndGenderOfKid: UILabel!
    @IBOutlet weak var contactOfKid: UILabel!
    @IBOutlet weak var parentsOfKid: UILabel!
    
    @IBOutlet weak var levelNumber: UILabel!
    @IBOutlet weak var playedTimes: UILabel!
    @IBOutlet weak var medTimes: UILabel!
    @IBOutlet weak var imageToText: UILabel!
    @IBOutlet weak var textToImage: UILabel!
    
    @IBOutlet weak var viewGraph: UIView!
    
    var child: Child?
    var avg: Array<Float>?
    var count: Array<Int>?
    var graphBars: Array<PNBar>?
    
    var shouldMovePie = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readAllDataFromFiles()
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
        var filePath = documentsPath[0]
        
        //print(orderedkidsList)
        filePath = filePath.stringByAppendingString("/" + (orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][0] as! String) + (orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][5] as! String) + ".png")
        
        let kid: AnyObject! = orderedkidsList[selectedIndexPath.section][selectedIndexPath.row]
        child = Child(kid: kid)
        
        nameOfKid.text = child!.name
        ageAndGenderOfKid.text = child!.age + " anos - "
            + child!.gender
        
        parentsOfKid.text = "Cuidadores: " +
            child!.fathersName + " e " +
            child!.mothersName
        
        contactOfKid.text = "Telefone: " + child!.parentsNumber
        
        profileImage.image = UIImage(contentsOfFile: filePath)
        backgroundImage.image =  UIImage(contentsOfFile: filePath)
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2;
        profileImage.clipsToBounds = true;
        
        profileImage.layer.borderWidth = 3.0
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        delay(0.1, closure: {
            let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurred = UIVisualEffectView(effect: blur)
            blurred.frame = self.backgroundImage.frame
            
            
            self.view.insertSubview(blurred, aboveSubview: self.backgroundImage)
        })

        loadGraph()
        self.navigationController?.navigationBar.translucent = true
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        isItEditing = true
        self.navigationController?.navigationBarHidden = false

    }
    
    func loadGraph(){
        
        let qr = QuestionRecord.readFromCSV("\(child!.name)\(child!.parentsNumber)")
        avg = qr.0
        count = qr.1

        
        
        var barChart = PNBarChart(frame: CGRectMake(10, 80, CGFloat(500), 250.0))
        barChart.backgroundColor = UIColor.clearColor()
        
        
        barChart.xLabels = ["Som para texto", "Som para imagem", "Imagem para texto","Texto para imagem"]
        barChart.yValues = [avg![0], avg![1], avg![2], avg![3]]
        

        barChart.strokeChart()
        graphBars = barChart.bars as NSArray as? Array<PNBar>

        viewGraph.addSubview(barChart)
        
        
        playedTimes.text = "Som para texto: \(count![0])"
        medTimes.text = "Som para imagem: \(count![1])"
        imageToText.text = "Imagem para texto: \(count![2])"
        textToImage.text = "Texto para imagem: \(count![3])"
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first
        
        if touch!.isEqual(graphBars![1]){
            print("hey")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyTest(sender: AnyObject) {
        self.performSegueWithIdentifier("sgQuiz", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "sgQuiz") {
            var quizVC = (segue.destinationViewController as! QuizViewController)
            quizVC.child = self.child
        }
    }

    // MARK: - Navigation
    
    
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }
}
