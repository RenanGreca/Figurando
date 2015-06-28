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
    @IBOutlet weak var imageToText: UILabel!
    @IBOutlet weak var textToImage: UILabel!
    
    @IBOutlet weak var viewGraph: UIView!
    
    var child: Child?
    var avg: Array<Float>?
    var count: Array<Int>?
    var graphBars: Array<PNBar>?
    
    let graph = PieLayer()
    var shouldMovePie = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: Selector("selectPie:"))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        
        
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

        
//        
//        var lineChart:PNLineChart = PNLineChart(frame: CGRectMake(0, 135.0, 320, 200.0))
//        lineChart.yLabelFormat = "%1.1f"
//        lineChart.showLabel = true
//        lineChart.backgroundColor = UIColor.clearColor()
//        lineChart.xLabels = ["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7"]
//        lineChart.showCoordinateAxis = true
//        
//        // Line Chart Nr.1
//        var data01Array: [CGFloat] = [60.1, 160.1, 126.4, 262.2, 186.2, 127.2, 176.2]
//        var data01:PNLineChartData = PNLineChartData()
//        data01.color = UIColor.greenColor()
//        data01.itemCount = data01Array.count
//        data01.inflexionPointStyle = PNLineChartPointStyle.Circle
//        //.PNLineChartPointStyle.PNLineChartPointStyleCycle
////        data01.getData = ({(index: Int) -> PNLineChartDataItem in
////            var yValue:CGFloat = data01Array[index]
////            var item = PNLineChartDataItem(y: yValue)
////            return item
////        })
//        
//        lineChart.chartData = [data01]
//        lineChart.strokeChart()
//        
        
        
//works
        
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
//        var chart = PNLineChart(frame: CGRectMake(0, 0, 400, 400))
//        chart.xLabels = ["aa", "bb", "cc"]
//
//        var dataArray = [55.5, 50.1, 4.4]
//        var data = PNLineChartData()
//        data.color = UIColor.blueColor()
//        data.itemCount = UInt(chart.xLabels.count)
//        
//        data.getData = {
//            index in
//            let yValue: CGFloat = initSignalExample[UInt(index)]
//            return PNLineChartDataItem(y: yValue)
//        }
//        
//        chart.strokeChart()
//        
//        viewGraph.addSubview(chart)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first
        
        if touch!.isEqual(graphBars![1]){
            print("hey")
        }
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
    
    
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }
}
