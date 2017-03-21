//
//  HGJExtention.swift
//  test
//
//  Created by 胡古斤 on 2017/1/17.
//  Copyright © 2017年 胡古斤. All rights reserved.
//

import UIKit




extension UIAlertAction {
    
    
     /** 修改ActionSheet的标题颜色 */
    func titleColor(color: UIColor) {
        setValue(color, forKey: "titleTextColor")
    }
    
    
    /** 
     
     *  description：用于创建ActionSheet
     * - 原始图片名,要求图片大小为 500@2x & 750@3x,最后图片颜色只与像素透明度有关
     * - 图片最终颜色，默认为浅蓝色
     
     */
    
    convenience init(HGJImageName: String, tintColor: UIColor, handle: ((UIAlertAction) -> Swift.Void)? = nil) {

        self.init(title: "", style: .default, handler: handle)
        self.backgroundImage(image: UIImage.init(named: HGJImageName)!, tintColor: tintColor)
        
    }
    
    
    
    /**
     
     *  description：用于修改ActionSheet的背景图片
     * - 原始图片,要求图片大小为 500@2x & 750@3x,最后图片颜色只与像素透明度有关
     * - 图片最终颜色，默认为浅蓝色
     
     */
    
    
    final func backgroundImage(image: UIImage, tintColor: UIColor) {

        setValue(tintColor, forKey: "_imageTintColor")
        setValue(image, forKey: "image")
    }
    
    
}








extension UIAlertController {

    //MARK: - Property
    
    /** 定义扩展属性key */
    struct showVcKey {
        
         static var vc = "HGJShowController"
        
    }
    
    
    /** 将要展示弹窗的控制器 */
    final var showVc : UIViewController? {
        set {
            objc_setAssociatedObject(self, &UIAlertController.showVcKey.vc, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &UIAlertController.showVcKey.vc) as? UIViewController
        }
    }
    
    
    
    
    
    
    //MARK: - Initial
    
    /** 弹窗模式 */
    convenience init(HGJAlertOn vc: UIViewController, Message details: String, withTitle flag: Bool = false) {
        
        // 0.是否包含"提示"标题
        let title = flag ? "提示" : ""
        self.init(title: title, message: details, preferredStyle: .alert)
        
        // 1.设置将要展示的控制器
        self.showVc = vc
    }
    
    /** 选择器模式 */
    convenience init(HGJActionSheetOn vc: UIViewController, Message details: String, withTitle flag: Bool = false) {
        
        // 0.是否包含"提示"标题
        let title = flag ? "提示" : ""
        self.init(title: title, message: details, preferredStyle: .actionSheet)
        
        
        // 1.设置将要展示的控制器
        self.showVc = vc
        
    }
    

    
    
    //MARK: - Interface
    
    /** 常用弹窗模式 */
    
    /** 用于创建弹窗提示，只包含取消按钮 */
    class func HGJShowAlert(okOn vc: UIViewController, alertMessage details: String) {
        
        // 1.创建alert
        let alert = UIAlertController.init(HGJAlertOn: vc, Message: details)
        
        // 2.添加按钮
        let ok = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
        alert.addAction(ok)
        
        // 3.显示
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    /** 用于创建弹窗提示，包含确定、取消按钮 */
    class func HGJShowAlert(ok_CancleOn vc: UIViewController, alertMessage details: String, handler: @escaping ((UIAlertAction) -> Swift.Void)) {
        
        // 1.创建alert
        let alert = UIAlertController.init(HGJAlertOn: vc, Message: details)
        
        // 2.添加按钮
        let ok = UIAlertAction.init(title: "确定", style: .default, handler: handler)
        alert.addAction(ok)
        
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancel)

        // 3.显示
        vc.present(alert, animated: true, completion: nil)
    }
    
    

    /** 用于创建选择器提示 */
    
     class func showHGJActionSheet(displayOn vc: UIViewController, alertMessage details: String) {
        
        // 暂时没做
    }
    
    
    
    /** 显示弹窗 */
    public func show() {
        self.showVc?.present(self, animated: true, completion: nil)
    }
    
    
    
}



