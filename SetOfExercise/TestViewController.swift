//
//  TestViewController.swift
//  SetOfExercise
//
//  Created by 胡古斤 on 2017/3/21.
//  Copyright © 2017年 胡古斤. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RunTime.getIvarList(UIAlertAction.self)
        
        
        
    }
    
    @IBAction func show() {
        
        
        
//        UIAlertController.HGJShowAlert(okOn: self, alertMessage: "test")
//        
//        UIAlertController.HGJShowAlert(ok_CancleOn: self, alertMessage: "test") { (alert) in
//            print("test")
//        }
        
        
        let alert = UIAlertController.init(HGJAlertOn: self, Message: "test")
        
        let action = UIAlertAction.init(HGJImageName: "man", tintColor: UIColor.blue) { (action) in
            print("test0")
        }
        alert.addAction(action)
        let action1 = UIAlertAction.init(HGJImageName: "man", tintColor: UIColor.red) { (action) in
            print("test1")
        }
        alert.addAction(action1)
        
        
        alert.show()
        
        
        
        
        
    }


}
