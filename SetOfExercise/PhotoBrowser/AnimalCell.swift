//
//  AnimalCell.swift
//  DownImages
//
//  Created by 胡古斤 on 2017/3/1.
//  Copyright © 2017年 胡古斤. All rights reserved.
//

import UIKit

class AnimalCell: UITableViewCell {
    
    
    @IBOutlet weak var animalImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!

    
    
    
    //MARK: - Property
    
    // 用于管理所有任务
    var queue : OperationQueue?
    
    // cell的下载任务
    var operationDic : Dictionary<String, BlockOperation>?
    
    // UITableView
    var tableView : UITableView?

    
    private var getModel : AnimalModel?
    
    var model : AnimalModel {
        
        set {
            
            self.getModel = newValue
            
            
            // 缓存里没有图片信息
            if newValue.image == nil {
                
                // 0.cell循环利用会显示之前cell的图片，增强用户体验可以给定占位图片
                self.animalImageView.image = UIImage()
                
                // 1.本地找
                let localPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
                let urlLastComponent = (newValue.url as NSString).lastPathComponent
                let imageLocalPath = localPath?.appending("/" + urlLastComponent)
                var image = UIImage.init(contentsOfFile: imageLocalPath!)
                
                
                // 1.1 本地存有图片
                if image != nil {
                    
                    // 1.2.缓存一份
                    newValue.image = image
                    self.animalImageView.image = image
                    
                }else {
                    
                    // 2.创建下载任务
                    
                    // 2.1 如果任务不存在才创建新任务
                    if self.operationDic?[urlLastComponent] == nil {
                        
                        self.operationDic?[urlLastComponent] = BlockOperation.init(block: {
                            
                            // 2.3 下载
                            let imageData = NSData.init(contentsOf: URL.init(string: newValue.url)!)
                            image = UIImage.init(data: imageData as! Data)
                            
                            Thread.sleep(forTimeInterval: 3)
                            
                            
                            // 2.4 本地化一份
                        imageData?.write(toFile: imageLocalPath!, atomically: true)
                            
                            
                            OperationQueue.main.addOperation({
                                
                                // 2.3 缓存一份
                                newValue.image = image
                                
                                // 2.4 重新加载视图，如果image直接给cell.imageView会出现循环利用显示有误的问题
                                self.tableView?.reloadData()
                                
                                _ = self.operationDic?.removeValue(forKey: urlLastComponent)
                                
                            })
                            
                        })
                        
                        
                        self.queue?.addOperation(self.operationDic![urlLastComponent]!)
                    }
                    
                    
                    
                }
                
                
            }else {
                // 缓存存有图片信息
                self.animalImageView.image = newValue.image
            }
            
            
            self.titleLabel.text = newValue.name
            self.detailLabel.text = newValue.detail
        }
        
        get {
            return getModel!
        }
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    class func creat(_ tableView: UITableView, _ queue: OperationQueue, _ operationDic: Dictionary<String, BlockOperation>) -> AnimalCell {
        let cell = Bundle.main.loadNibNamed("AnimalCell", owner: nil, options: nil)?.last as! AnimalCell
        cell.tableView = tableView
        cell.queue = queue
        cell.operationDic = operationDic
        return cell
    }
    
    
    
    
    
}




class AnimalModel: NSObject {

    var image : UIImage?
    
    var url = String()
    
    var name = String()
    
    var detail = String()
    
    
    convenience init(_ dic: Dictionary<String, String>) {
        self.init()
        self.setValuesForKeys(dic)
    }
    
    
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        let dic = ["icon" : "url", "name" : "name", "download" : "detail"]

        guard dic.keys.contains(key) else {
            return
        }
        
        super.setValue(value, forKey: dic[key]!)
    }
    
    
    
}
