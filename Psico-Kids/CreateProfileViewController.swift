//
//  CreateProfileViewController.swift
//  Psico-Kids
//
//  Created by Samuel Lucas Ribeiro Cortez on 15/06/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit

var profilePicture = NSData()

class CreateProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var selectPhoto: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var kidsName: UITextField!
    @IBOutlet weak var kidsAge: UITextField!
    @IBOutlet weak var kidsGender: UITextField!
    @IBOutlet weak var fathersName: UITextField!
    @IBOutlet weak var mothersName: UITextField!
    @IBOutlet weak var parentsNumber: UITextField!
    
    @IBOutlet weak var yPositionForProfilePic: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        var tap = UITapGestureRecognizer(target: self, action: Selector("tapped:"))
        tap.numberOfTapsRequired = 1
        tap.delegate = self
        selectPhoto.addGestureRecognizer(tap)
        
        
        selectPhoto.layer.cornerRadius = selectPhoto.frame.size.width / 2;
        selectPhoto.clipsToBounds = true;
        
        selectPhoto.layer.borderWidth = 3.0
        selectPhoto.layer.borderColor = UIColor.whiteColor().CGColor
        
        if isItEditing {
            kidsName.text = orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][0] as? String
            kidsAge.text = orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][1] as? String
            kidsGender.text = orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][2] as? String
            fathersName.text = orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][3] as? String
            mothersName.text = orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][4] as? String
            parentsNumber.text = orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][5] as? String
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
            var filePath = documentsPath[0]
            filePath = filePath.stringByAppendingString("/" + (orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][0] as! String) + (orderedkidsList[selectedIndexPath.section][selectedIndexPath.row][5] as! String) + ".png")
            
            selectPhoto.image = UIImage(contentsOfFile: filePath)
            backgroundImage.image = UIImage(contentsOfFile: filePath)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillAppear:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillAppear(notification: NSNotification){
        yPositionForProfilePic.constant += 120
        self.view.center.y -= 250
    }
    
    func keyboardWillDisappear(notification: NSNotification){
            yPositionForProfilePic.constant -= 120
            self.view.center.y += 250
    }
    
    
    @IBAction func saveData(sender: AnyObject) {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
        var filePath = documentsPath[0]
        
        var imagePath = filePath.stringByAppendingString("/" + kidsName.text + parentsNumber.text + ".png")
        profilePicture = UIImagePNGRepresentation(selectPhoto.image)
        profilePicture.writeToFile(imagePath, atomically: true)
        
        filePath = filePath.stringByAppendingString("/KidsList.csv")
        
        
        if isItEditing {
            
            orderedkidsList[selectedIndexPath.section].removeObjectAtIndex(selectedIndexPath.row)
            updateCVSData()
            readAllDataFromFiles()
        }
        
        var newProfile = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil)!

        newProfile = newProfile.stringByAppendingString(     kidsName.text +
                                                        ";" + kidsAge.text +
                                                        ";" + kidsGender.text +
                                                        ";" + fathersName.text +
                                                        ";" + mothersName.text +
                                                        ";" + parentsNumber.text + ";$")

        newProfile.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
    
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func tapped (sender: AnyObject) {
        var picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        picker.modalPresentationStyle = UIModalPresentationStyle.Popover
        picker.popoverPresentationController?.sourceView = selectPhoto
        picker.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Down
        
        
        var chooseImageSource = UIAlertController(title: "Selecione a fonte da imagem",
                                                message: "De onde retirá-la?",
                                         preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        
        var cameraOption = UIAlertAction(title: "Tirar uma foto",
                                         style: UIAlertActionStyle.Default,
                                       handler: {finished in
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(picker, animated: true, completion: nil)})
        
        
        var libraryOption = UIAlertAction(title: "Escolher da galeria",
                                          style: UIAlertActionStyle.Default,
                                        handler: {finished in
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(picker, animated: true, completion: nil)})
        
        
        
        chooseImageSource.addAction(cameraOption)
        chooseImageSource.addAction(libraryOption)
        
        chooseImageSource.modalPresentationStyle = UIModalPresentationStyle.Popover
        chooseImageSource.popoverPresentationController?.sourceView = selectPhoto
        chooseImageSource.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Down
        
        
        self.presentViewController(chooseImageSource, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            var selectedImage: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
            self.selectPhoto.image = selectedImage
            self.backgroundImage.image = selectedImage
        
            profilePicture = UIImagePNGRepresentation(selectedImage)
            
            picker.dismissViewControllerAnimated(true, completion: nil)
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
