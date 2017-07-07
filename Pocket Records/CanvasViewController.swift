//
//  CanvasViewController.swift
//  Pocket Records
//
//  Created by Kya Suzuki on 7/1/17.
//  Copyright © 2017 Kya Suzuki. All rights reserved.
//

import UIKit

//protocol DataSentDelegate{
   // func userDidEnterData(data: Any)
//}

class CanvasViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    //var delegate: DataSentDelegate? = nil
    
    // private var selectedText: String? = ""
    
    private var selectedImage: UIImage?
    
    // the controllwer for the popup that appears from the bottom when the user clicks the camera button
    let alertController = UIAlertController()
    
    // The canvas element --> specifically for the image option
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBAction func cameraButton(_ sender: UIButton) {
        cameraPopup()
        if myImageView.isHidden {
            myImageView.isHidden = false
            myImageView.image = selectedImage
            myTextField.isHidden = true
            myDrawView.isHidden = true
        }else {
            myImageView.isHidden
                = true
        }
    }
    
    // the function to get the camera to open up or the photo library to open up if the user selects either option
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
    
    // this function goes along with the cameraPopup function; it just sets the selected image as the image on the imageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        myImageView.image = image
        selectedImage = image
        // image is our desired image
        
        picker.dismiss(animated: true, completion: nil)
    }
 /////////////////////////////////////////////////////////
    
    
    @IBAction func textButton(_ sender: UIButton) {
        if myTextField.isHidden {
            myTextField.isHidden = false
            myImageView.isHidden = true
            myDrawView.isHidden = true
            myTextField.becomeFirstResponder()
        }else {
            myTextField.isHidden
                = true
            myTextField.resignFirstResponder()
        }
    }

    @IBOutlet weak var myTextField: UITextView!
    
    // dismisses keyboard when press return on toggle keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            myTextField.resignFirstResponder()
            return false
        }
        return true
    }
    
    
//    @IBAction func saveButton(_ sender: UIButton) {
//        if delegate != nil{
//            if (myTextField.isHidden == false && myTextField.text != nil){
//                let data = myTextField.text
//                delegate?.userDidEnterData(data: data! as String )
//            }
//            if (myImageView.isHidden == false && myImageView.image != nil){
//                myImageView.image = selectedImage
//                let data = myImageView.image
//                delegate?.userDidEnterData(data: data! as UIImage)
//            }
//             self.navigationController?.popViewController(animated: true)
//        }
//        
//    }
//////////////////////////////////////////////////////////
    
    @IBOutlet weak var myDrawView: UIImageView!
    
    @IBAction func drawButton(_ sender: UIButton) {
        if myDrawView.isHidden {
            myDrawView.isHidden = false
            myImageView.isHidden = true
            myTextField.isHidden = true
        }else {
            myDrawView.isHidden
                = true
        }
    }
    
    var lastPoint = CGPoint.zero
    var swiped = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.myDrawView)
        }
    }
    
    func drawLines(fromPoint:CGPoint, toPoint:CGPoint){
        UIGraphicsBeginImageContext(self.myDrawView.frame.size)
        myDrawView.image?.draw(in: CGRect(x: 0, y: 0, width: self.myDrawView.frame.width, height: self.myDrawView.frame.height))
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(5)
        context?.setStrokeColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor)
        //(cyan: 0 , magenta: 0, yellow: 0, black: 1.0, alpha: 1.0)
        
        context?.strokePath()
        myDrawView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        
        if let touch = touches.first{
            let currentPoint = touch.location(in: self.myDrawView)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
    
    /////////////////////////////////////////////////////
    
    @IBAction func trash(_ sender: UIButton) {
        self.myDrawView.image = nil
        self.myTextField.text = nil
        self.myImageView.image = nil
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.myTextField.delegate = self    }
    
    
    // gets rid of hairline border line on navigation bar
    private var shadowImageView: UIImageView?
    
    private func findShadowImage(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }
        
        for subview in view.subviews {
            if let imageView = findShadowImage(under: subview) {
                return imageView
            }
        }
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if shadowImageView == nil {
            shadowImageView = findShadowImage(under: navigationController!.navigationBar)
        }
        shadowImageView?.isHidden = true
        navigationController?.navigationBar.barTintColor = UIColor .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        shadowImageView?.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
}
