//
//  HGJGetCodeBtn.swift
//  getcode
//
//  Created by 胡古斤 on 2017/1/7.
//  Copyright © 2017年 胡古斤. All rights reserved.
//

import UIKit

final class HGJGetCodeBtn: UIButton {


    
    //MARK: - 创建单例
    private static var shared = HGJGetCodeBtn()
    
    static func shared(frame: CGRect?) -> HGJGetCodeBtn {
    
        let singleton = HGJGetCodeBtn.shared
        
        if frame != nil {
            singleton.frame = frame!
        }
    
        return singleton
    }
    
    
    
    //MARK: - Property
    
    /** 倒计时 */
    private var timer : Timer!
    private var leftTime = 0
    
    
    
    
    
    
    //MARK: - Initial
    
    convenience private init() {
        self.init(frame: CGRect.init(x: 0, y: 0, width: 90, height: 44))
    }
    
    override private init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // 1.Setup UI
        self.setTitle("获取验证码", for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.backgroundColor = UIColor.init(white: 1, alpha: 1).withAlphaComponent(0)
        self.setTitleColor(UIColor.colorWithHex(hex: "3fce38"), for: .normal)
        
        
        // 2.Action
        self.addTarget(self, action: #selector(self.click), for: .touchUpInside)
        
        
    }
    
    
    required internal init?(coder aDecoder: NSCoder) {
        fatalError("该类是单例模式,没有提供xib初始化方法")
    }

    
    
    
    
    
    //MARK: - BtnAction
    @objc private func click() {
        
        self.leftTime = 120
        self.alpha = 0.5
        self.isEnabled = false
        self.timer = Timer.scheduledTimer(timeInterval: 1,target:self,selector:#selector(self.verifyTime),userInfo:nil,repeats:true)

    }
    
    
    @objc private func verifyTime() {
        
        self.leftTime -= 1
        if(leftTime>=0){
            self.titleLabel?.text = "\(self.leftTime)" + "秒后重试"
            self.setTitle("\(self.leftTime)" + "秒后重试", for: .normal)
            
        }else{
            
            self.isEnabled = true
            self.setTitle("获取验证码", for: .normal)
            self.alpha = 1
            self.timer.invalidate()
            
        }
        
    }
    
    
    

}
