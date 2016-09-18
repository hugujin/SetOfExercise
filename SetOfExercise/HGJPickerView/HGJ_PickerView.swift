//
//  HGJ_PickerView.swift
//  mytest
//
//  Created by 胡古斤 on 16/7/31.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

import UIKit

class HGJ_PickerView: UIView {
    
    
    //MAKR: - Property
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    let showFrame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
    let dismissFrame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
    
    var delegate:UIPickerViewDelegate?
    var dataSource: UIPickerViewDataSource?
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    
    //MARK: - DesignedInital
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, UIScreen.mainScreen().bounds.height, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    }

    convenience init() {
        self.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
//        self.pickerView.delegate = self.delegate
//        self.pickerView.dataSource = self.dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
    
    //MARK: - IBAction
    @IBAction func dissMissBackgroundAction() {
        self.dismissAll()
    }
    
    
    @IBAction func cancelAction() {
        self.dismissAll()
    }
    
    @IBAction func determainAction() {
        self.showAll()
    }
    
    
    
    //MARK: - PraviteFucntions
    func dismissAll()
    {
        UIView.animateWithDuration(0.3) { 
            self.frame = self.dismissFrame
        }
    }
    
    func showAll()
    {
        UIView.animateWithDuration(0.3) { 
           self.frame = self.showFrame
        }
        
    }
    
}

