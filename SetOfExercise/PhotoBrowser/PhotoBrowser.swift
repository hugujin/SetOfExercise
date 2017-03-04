//
//  PhotoBrowser.swift
//  DownImages
//
//  Created by 胡古斤 on 2017/2/27.
//  Copyright © 2017年 胡古斤. All rights reserved.
//

import UIKit





class PhotoBrowser: UITableViewController {
    
    //MARK: - Property
    
    /** 懒加载表示图数据源 */
    lazy var tableArr : Array<AnimalModel> = {
        
            let path = Bundle.main.path(forResource: "animals.plist", ofType: nil)
            let srcArr = NSArray.init(contentsOfFile: path!)
            var desArr = Array<AnimalModel>()
        
            for i in 0..<(srcArr?.count)! {
                
                let animal = AnimalModel.init(srcArr?[i] as! Dictionary<String, String>)
                desArr.append(animal)
            }
            return desArr
        
    }()
    
    /** 管理下载任务 */
    lazy var queue : OperationQueue = {
       
        let queue = OperationQueue()
        
        // 最大并发数
        queue.maxConcurrentOperationCount = 3
        
        return queue
    }()
    
    
    /** 所有下载任务 */
    var operationDic = Dictionary<String, BlockOperation>()
    
    
    
    //MARK: - Life cycle
    
    override func loadView() {
        
        self.view = UITableView()
        
        (self.view as! UITableView).dataSource = self
        (self.view as! UITableView).delegate = self
        
    }


    
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "照片浏览"
    }

    
    
    
    //MARK: - Tableview Delegate & datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AnimalCell
        if cell == nil {
            cell = AnimalCell.creat(tableView ,self.queue, self.operationDic)
        } 
        
        let animal = self.tableArr[indexPath.row]
        cell?.model = animal
        
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    

}

