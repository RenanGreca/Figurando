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
    @IBOutlet weak var kidsName: UITextField!
    @IBOutlet weak var kidsAge: UITextField!
    @IBOutlet weak var kidsGender: UITextField!
    @IBOutlet weak var fathersName: UITextField!
    @IBOutlet weak var mothersName: UITextField!
    @IBOutlet weak var parentsNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var tap = UITapGestureRecognizer(target: self, action: Selector("tapped:"))
        tap.numberOfTapsRequired = 1
        tap.delegate = self
        selectPhoto.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func saveData(sender: AnyObject) {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
        var filePath = documentsPath[0]
        
        var imagePath = filePath.stringByAppendingString("/" + kidsName.text + parentsNumber.text + ".png")
        profilePicture.writeToFile(imagePath, atomically: true)
        
        filePath = filePath.stringByAppendingString("/KidsList.csv")
        
        var newProfile = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil)!

        newProfile = newProfile.stringByAppendingString(";" + kidsName.text +
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
        picker.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Right
        
        
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
        
        
        self.presentViewController(chooseImageSource, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            var selectedImage: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
            self.selectPhoto.image = selectedImage
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
