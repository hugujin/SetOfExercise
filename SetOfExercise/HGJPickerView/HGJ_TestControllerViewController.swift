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
        self.chooseProvince!.backgroundColor = UIColor.green
        
//        self.chooseProvince?.showAll()
        self.chooseProvince!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    
    
    
    
    
    
    //MARK: - UIPickerViewDatasource & UIPickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 32
    }
    
//    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 30
//    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "深圳市"
    }
    
    
    
    
    //MARK: - PrivateFunctions
    
    func showPickerView(){
        
        UIView.animate(withDuration: 0.3, animations: { 
            self.chooseProvince?.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: UIScreen.main.bounds.width, height: 200)
        }) 
    }
    
    
    
    
    
    
}
