//
//  HGJExtension.swift
//  自由学
//
//  Created by 胡古斤 on 2017/1/7.
//  Copyright © 2017年 胡古斤. All rights reserved.
//

import UIKit


extension UIColor{

    
    /** 主题颜色(天蓝色) */
    final class var themeColor : UIColor {
        return UIColor.colorWithHex(hex: "29a1f7", alpha: 1)
    }
    
    
    /** 16进制颜色表示 */
    class func colorWithHex(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        
        var rgb : UInt32 = 0
        
        let scanner = Scanner(string: hex)
        
        if hex.hasPrefix("#") { // 跳过“#”号
            scanner.scanLocation = 1
        }
        
        scanner.scanHexInt32(&rgb)
        
        let r = CGFloat((rgb & 0xff0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0xff00) >> 8) / 255.0
        let b = CGFloat(rgb & 0xff) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
        

}
    
    
    

