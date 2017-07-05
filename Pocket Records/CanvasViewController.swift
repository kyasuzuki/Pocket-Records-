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
        cameraPopup()
    }
    
    func cameraPopup() {
        let camera = CameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (alert : UIAlertAction!) in
            camera.getCameraOn(self, canEdit: true)
        }
        let sharePhoto = UIAlertAction(title: "Photo Library", style: .default) { (alert : UIAlertAction!) in
            camera.getPhotoLibraryOn(self, canEdit: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        myImageView.image = image
        
        // image is our desired image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad(){
               super.viewDidLoad()
//              self.navigationController!.navigationBar.isHidden = true    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
    
}
