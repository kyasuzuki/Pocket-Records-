//
//  CanvasViewController.swift
//  Pocket Records
//
//  Created by Kya Suzuki on 7/1/17.
//  Copyright © 2017 Kya Suzuki. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let alertController = UIAlertController()
    

    @IBOutlet weak var myImageView: UIImageView!
    
    
    @IBAction func cameraButton(_ sender: UIButton) {
        cameraOptionPopup()
    }
    
    func cameraOptionPopup(){
        //Creating UIAlertController and
        
        //the confirm action taking the inputs
        let cameraAction = UIAlertAction(title: "Open Camera", style: .default) { (UIAlertAction) in
             // this is called when the user presses the Camera button
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }
        
        let libraryAction = UIAlertAction(title: "Open Photo Library", style: .default) { (UIAlertAction) in
            // this is called when the user presses the Photo Library button
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            picker.allowsEditing = false
            
            self.present(picker, animated: true, completion: nil)
        }
        
        func imagePickerController(picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[String:AnyObject])
        {
            if let picker = info[UIImagePickerControllerOriginalImage] as? UIImage{
                myImageView.image = picker
            }
            self.dismiss(animated: true, completion: nil)
            
            
//            myCanvasView.image = info[UIImagePickerControllerOriginalImage] as? UIImage; dismiss(animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in }
        
        alertController.addAction(cameraAction)
        
        alertController.addAction(libraryAction)
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:nil)
            
    }
    
    
    override func viewDidLoad(){
               super.viewDidLoad()
//              self.navigationController!.navigationBar.isHidden = true    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
    
}
