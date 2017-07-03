//
//  CanvasViewController.swift
//  Pocket Records
//
//  Created by Kya Suzuki on 7/1/17.
//  Copyright © 2017 Kya Suzuki. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    @IBOutlet weak var myCanvasView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
              self.navigationController!.navigationBar.isHidden = true    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
    
}
