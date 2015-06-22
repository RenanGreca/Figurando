//
//  QuizViewController.swift
//  Psico-Kids
//
//  Created by Felipe Ramon de Lara on 6/16/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVFoundation

class QuizViewController: UIViewController {

    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    

    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    
    var records: Array<QuestionRecord> = []
    var timerCounter = 0

    var objects : Array<Object> = []
    var indexObjectToIdentify : Int = 0
    var quizMode: QuestionTypes?
    var buttonPressed: Int?
    var audioPlayer = AVAudioPlayer()
    
    var seconds = 0.0
    var timer = NSTimer()
    
    var questionToRead: String?

    enum QuestionTypes: Int {
        case soundToText, soundToImage, imageToText, textToImage
        
        static func random() -> QuestionTypes {  // I called this "maximumRawValue" in the post
            var max: Int = 0
            while let _ = self(rawValue: ++max) {}
            
            let rand = Int(arc4random_uniform(UInt32(max)))
            return self(rawValue: rand)!
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ObjectList.Static.instance.populate()
        nextQuestion()
    
    }
    
    func updateTimer() {
        timerCounter++
    }
    
    func nextQuestion() {
        clearOptions()
        
        objects = ObjectList.Static.instance.getRandomObjects(3)
        indexObjectToIdentify = Int(arc4random_uniform(UInt32(objects.count)))
        quizMode = QuestionTypes.random()
        
        
        switch quizMode! {
        case .imageToText:
            questionLabel.text = "Qual é a palavra da imagem abaixo?"
            questionImageView.image = UIImage(contentsOfFile: "\(objects[indexObjectToIdentify].img)")
        case .textToImage:
            questionLabel.text = "Qual é a imagem da palavra \(objects[indexObjectToIdentify].name)?"
        case .soundToImage:
            
            questionLabel.text = "Qual é a imagem da palavra ouvida?"
            questionToRead = "frase3"
            repeatSound()
            
        case .soundToText:
            
            questionLabel.text = "Qual foi a palavra ouvida?"
            questionToRead = "frase4"
            repeatSound()
        }

    
        if quizMode == QuestionTypes.imageToText || quizMode == QuestionTypes.soundToText {
            option1Button.setTitle("\(objects[0].name)", forState: .Normal)
            option2Button.setTitle("\(objects[1].name)", forState: .Normal)
            option3Button.setTitle("\(objects[2].name)", forState: .Normal)
        } else if quizMode == QuestionTypes.textToImage || quizMode == QuestionTypes.soundToImage {
            option1Button.setImage(UIImage(contentsOfFile: "\(objects[0].img)"), forState: UIControlState.Normal)
            option2Button.setImage(UIImage(contentsOfFile: "\(objects[1].img)"), forState: UIControlState.Normal)
            option3Button.setImage(UIImage(contentsOfFile: "\(objects[2].img)"), forState: UIControlState.Normal)
        }
        
//        option1Label.text = "\(objects[0].name)"
//        option1Label.text = "\(objects[0].name)"
//        option1Label.text = "\(objects[0].name)"

        
    }
//    
    func repeatSound(){
        let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), questionToRead, "mp3", nil)
        audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, fileTypeHint: "mp3", error: nil)
        audioPlayer.play()

        setupTimer()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "doCountdown:", userInfo: nil, repeats: true)
    
    }
    
    
    func setupTimer()  {
        seconds = audioPlayer.duration - 2
    }
    
    func doCountdown(timer: NSTimer) {
        if(seconds > 0)  {
            seconds--
        }else{
            let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), objects[indexObjectToIdentify].name, "mp3", nil)
            audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, fileTypeHint: "mp3", error: nil)
            audioPlayer.play()
            timer.invalidate()
        }
    }
    
    
    func clearOptions(){
        questionImageView.image = nil
        option1Button.setImage(nil, forState: UIControlState.Normal)
        option2Button.setImage(nil, forState: UIControlState.Normal)
        option3Button.setImage(nil, forState: UIControlState.Normal)
        timer.invalidate()
        timerCounter = 0

    }
    
    func recordAnswer(){

        var questionRecord = QuestionRecord(objectToIdentify: objects[indexObjectToIdentify].name, option1: objects[0].name, option2: objects[1].name, option3: objects[2].name, selectedOption: buttonPressed!, elapsedTimeInSeconds: timerCounter, questionType: quizMode!.rawValue)
        
        println("Asked: \(objects[indexObjectToIdentify].name), Object selected: \(objects[buttonPressed! - 1].name)")
        
    }
    
    @IBAction func option1ButtonPressed(sender: AnyObject) {
        buttonPressed = 1
        recordAnswer()

        nextQuestion()
    }
    @IBAction func option2ButtonPressed(sender: AnyObject) {
        buttonPressed = 2
        
        recordAnswer()
        nextQuestion()
    }
    @IBAction func option3ButtonPressed(sender: AnyObject) {
        buttonPressed = 3
        
        recordAnswer()
        nextQuestion()
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
