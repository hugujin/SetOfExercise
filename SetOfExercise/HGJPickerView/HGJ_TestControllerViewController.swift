//
//  HGJ_TestControllerViewController.swift
//  mytest
//
//  Created by 胡古斤 on 16/7/31.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

import UIKit

class HGJ_TestControllerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - Property
    var chooseProvince: HGJ_PickerView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    //MAKR: - ButtonAction
    /** 创建PickerView*/
    @IBAction func creatPickerView() {
        self.chooseProvince = HGJ_PickerView.init()
//        self.chooseProvince!.delegate = self
//        self.chooseProvince!.dataSource = self
        self.view.addSubview(self.chooseProvince!)
        self.chooseProvince!.backgroundColor = UIColor.greenColor()
        
//        self.chooseProvince?.showAll()
        self.chooseProvince!.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
    }
    
    
    
    
    
    
    
    //MARK: - UIPickerViewDatasource & UIPickerViewDelegate
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 32
    }
    
//    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 30
//    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "深圳市"
    }
    
    
    
    
    //MARK: - PrivateFunctions
    
    func showPickerView(){
        
        UIView.animateWithDuration(0.3) { 
            self.chooseProvince?.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height - 200, UIScreen.mainScreen().bounds.width, 200)
        }
    }
    
    
    
    
    
    
}
