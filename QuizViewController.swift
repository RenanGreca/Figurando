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
    

    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    
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
    
    func nextQuestion() {
        
        let objects : Array<Object> = ObjectList.Static.instance.getRandomObjects(3)
        
        let indexObjectToIdentify = Int(arc4random_uniform(UInt32(objects.count)))
        let quizMode: QuestionTypes = QuestionTypes.random()
        
        switch quizMode {
        case .imageToText:
            questionLabel.text = "Qual é a palavra da imagem abaixo?"
        case .textToImage:
            questionLabel.text = "Qual é a imagem da palavra \(objects[indexObjectToIdentify].name)?"
        case .soundToImage:
            questionLabel.text = "Qual é a imagem da palavra ouvida?"
        case .soundToText:
            questionLabel.text = "Qual foi a palavra ouvida?"
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
