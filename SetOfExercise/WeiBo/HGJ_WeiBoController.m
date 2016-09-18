//
//  HGJ_WeiBoController.m
//  mytest
//
//  Created by 胡古斤 on 16/7/5.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "HGJ_WeiBoController.h"
#import "HGJ_StateCell.h"

@interface HGJ_WeiBoController ()

/** 数据源 */
@property (strong, nonatomic) NSArray * tableArray;

@end

@implementation HGJ_WeiBoController

/**
 *  数据懒加载
 */
- (NSArray *)tableArray
{
    if (!_tableArray) {
        NSString * path = [[NSBundle mainBundle]pathForResource:@"state.plist" ofType:nil];
        NSArray * cellArr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * tempArr = [[NSMutableArray alloc]init];
        for (NSDictionary * cellDic in cellArr) {
            HGJ_StateModel * cellModel = [HGJ_StateModel stateModel: cellDic];
            
            [tempArr addObject:cellModel];
        }
        _tableArray = tempArr;
    }
    return _tableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微博热门";
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {;
    
    HGJ_StateModel * model = self.tableArray[indexPath.row];
    return model.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HGJ_StateCell * stateCell = [HGJ_StateCell cellWithTableView:tableView];
    stateCell.model = _tableArray[indexPath.row];
    return stateCell;
}


/**
 *  此方法用来让行高函数每次调用都在CEll函数调用之后马上运行，如果不使用该方法会比较难实现实时计算行高，并且还可以提高效率
 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

@end
