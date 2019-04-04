//
//  ViewController.swift
//  PTTextField
//
//  Created by prizetete on 04/03/2019.
//  Copyright (c) 2019 prizetete. All rights reserved.
//

import UIKit
import PTTextField

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mPTTextField: PTTextField!
//    private var oPTTextField:
    
//    private var oPTTextField: P
//
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mPTTextField.setupPTTextField(target: self, sTextShow: "EiEiEi 123")
//        self.view.addSubview(self.oPTTextField)
//        self.oPTTextField.setupPTTextField(sTextShow: "Sawaddee kubb")
//        self.oPTTextField.translatesAutoresizingMaskIntoConstraints = false
//        self.oPTTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0).isActive = true
//        self.oPTTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0).isActive = true
//        self.oPTTextField.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
//        self.oPTTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160.0).isActive = true
//        // Do any additional setup after loading the view, typically from a nib.
//    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


