//
//  CanvasViewController.swift
//  Pocket Records
//
//  Created by Kya Suzuki on 7/1/17.
//  Copyright © 2017 Kya Suzuki. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var drawPicker: UIPickerView!
    
    var drawArray = ["Draw", "Journal", "Camera"]
    
    @IBOutlet weak var myCanvasView: UIImageView!

    @IBOutlet weak var tempView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawPicker.delegate = self
        drawPicker.dataSource = self
        self.navigationController!.navigationBar.isHidden = true    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return drawArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return drawArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}
