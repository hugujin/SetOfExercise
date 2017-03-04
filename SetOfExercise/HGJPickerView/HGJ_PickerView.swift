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
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let showFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    let dismissFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    var delegate:UIPickerViewDelegate?
    var dataSource: UIPickerViewDataSource?
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    
    //MARK: - DesignedInital
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
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
        UIView.animate(withDuration: 0.3, animations: { 
            self.frame = self.dismissFrame
        }) 
    }
    
    func showAll()
    {
        UIView.animate(withDuration: 0.3, animations: { 
           self.frame = self.showFrame
        }) 
        
    }
    
}

