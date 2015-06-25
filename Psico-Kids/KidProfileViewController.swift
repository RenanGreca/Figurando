//
//  KidProfileViewController.swift
//  Psico-Kids
//
//  Created by Samuel Lucas Ribeiro Cortez on 16/06/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit
import MagicPie

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
    
    @IBOutlet weak var viewGraph: UIView!
    
    var child: Child?
    var avg: Array<Float>?
    var count: Array<Int>?
    
    let graph = PieLayer()
    var shouldMovePie = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: Selector("selectPie:"))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        
        loadGraph()
        
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
        
        
//        graph.frame = CGRectMake(10, 10, 400, 400)
//        graph.maxRadius = 150
//        graph.minRadius = 25
//        graph.startAngle = 180
//        graph.endAngle = 0
//        
//        let qr = QuestionRecord.readFromCSV("\(child!.name)\(child!.parentsNumber)")
//        avg = qr.0
//        count = qr.1
//        var alpha:CGFloat = 1.0
//        
//        /*for a in avg {
//            var element = PieElement(value: avg[0], color: UIColor(red: 228/255, green: 241/255, blue: 254/255, alpha: alpha))
//            element.centrOffset += 2
//            graph.addValues([element], animated: true)
//            alpha -= 0.1
//        }*/
//        
//        var elementOne = PieElement(value: avg![0], color: UIColor(red: 228/255, green: 241/255, blue: 254/255, alpha: 1))
//        var elementTwo = PieElement(value: avg![1], color: UIColor(red: 197/255, green: 239/255, blue: 247/255, alpha: 1))
//        var elementThree = PieElement(value: avg![2], color: UIColor(red: 107/255, green: 185/255, blue: 240/255, alpha: 1))
//        var elementFour = PieElement(value: avg![3], color: UIColor(red: 100/255, green: 185/255, blue: 240/255, alpha: 1))
//        var elementFive = PieElement(value: 0, color: UIColor(red: 107/255, green: 175/255, blue: 240/255, alpha: 1))
//        var elementSix = PieElement(value: 0, color: UIColor(red: 107/255, green: 185/255, blue: 230/255, alpha: 1))
//        var elementSeven = PieElement(value: 0, color: UIColor(red: 107/255, green: 180/255, blue: 235/255, alpha: 1))
//        
//        elementOne.centrOffset += 2
//        elementTwo.centrOffset += 2
//        elementThree.centrOffset += 2
//        elementFour.centrOffset += 2
//        elementFive.centrOffset += 2
//        elementSix.centrOffset += 2
//        elementSeven.centrOffset += 2
//        
//        graph.addValues([elementOne], animated: true)
//        graph.addValues([elementTwo], animated: true)
//        graph.addValues([elementThree], animated: true)
//        graph.addValues([elementFour], animated: true)
//        graph.addValues([elementFive], animated: true)
//        graph.addValues([elementSix], animated: true)
//        graph.addValues([elementSeven], animated: true)
//        
//        viewGraph.layer.addSublayer(graph)
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        isItEditing = true
        self.navigationController?.navigationBarHidden = false

    }
    
    func selectPie (tap : UIGestureRecognizer) {
        let pointOnGraph = tap.locationInView(viewGraph)
        let elementOfGraph = graph.pieElemInPoint(pointOnGraph)
        
        if (elementOfGraph != nil){
            print("elemento isnt nil")
            if (elementOfGraph.centrOffset == 2 && shouldMovePie){
                PieElement.animateChanges{
                    elementOfGraph.centrOffset = 22
                }
                shouldMovePie = false
                updatePieSliceInfo(pointOnGraph)
            }else{
                PieElement.animateChanges{
                    elementOfGraph.centrOffset = 2
                }
                shouldMovePie = true
            }
        }
        
    }
    
    
    func loadGraph(){
    
//        var chart = PNBarChart(frame: CGRectMake(0, 0, 400, 400))
//        chart.xLabels = ["aa", "bb", "cc"]
//        chart.yLabels = [20, 12, 311]
//        chart.strokeChart()
//        
//        viewGraph.addSubview(chart)

        var chart = PNLineChart(frame: CGRectMake(0, 0, 400, 400))
        chart.xLabels = ["aa", "bb", "cc"]

        var dataArray = [55.5, 50.1, 4.4]
        var data = PNLineChartData()
        data.color = UIColor.blueColor()
        data.itemCount = chart.xLabels.count
        
        data.getData = //help
        
        chart.strokeChart()
        
        viewGraph.addSubview(chart)
        
    }
    
    func updatePieSliceInfo (pieSlice: CGPoint) {
        
        let i = Int(graph.indexOfSliceFromPoint(pieSlice))
        switch (i){
        case 0:
            levelNumber.text = "Som para texto"
            break
        case 1:
            levelNumber.text = "Som para imagem"
            break
        case 2:
            levelNumber.text = "Imagem para texto"
            break
        case 3:
            levelNumber.text = "Texto para imagem"
            break
        case 4:
            levelNumber.text = "Quinta Fase"
            break
        case 5:
            levelNumber.text = "Sexta Fase"
            break
        case 6:
            levelNumber.text = "Sétima Fase"
            break
        default:
            break
        }
        
        playedTimes.text = "Quantidade de vezes jogadas: \(count![i])"
        medTimes.text = "Média de segundos por partida: \(avg![i])"

        
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
    
    
    
    
}
