//
//  MainMenuController.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/5.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "MainMenuController.h"
#import "MainMenuModel.h"
#import "SetOfExercise-Swift.h"

@interface MainMenuController ()

/** arrayForTable */
@property (strong, nonatomic) NSMutableArray * menuArray;

@end

@implementation MainMenuController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置行高
    self.tableView.rowHeight = 30;
    
    //去掉多余分割线
    self.tableView.tableFooterView = [[UIView alloc]init];

}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        MainMenuModel * model = self.menuArray[indexPath.row];
        cell.textLabel.text = model.content;
        cell.detailTextLabel.text = model.details;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainMenuModel * model = self.menuArray[indexPath.row];
    
    UIViewController * controller;
    controller = [[NSClassFromString(model.className) alloc]init];
    [self.navigationController pushViewController:controller animated:true];
    
}





#pragma mark - PraviteFucntions


- (NSArray *)menuArray
{
    if (_menuArray == nil) {
        
        NSString * path = [[NSBundle mainBundle]pathForResource:@"MainPlist.plist" ofType:nil];
        NSArray * arr = [NSArray arrayWithContentsOfFile:path];
        
        _menuArray = [[NSMutableArray alloc]init];
        for (NSDictionary * dic in arr) {
            MainMenuModel * model = [MainMenuModel modelWithDic:dic];
            [_menuArray addObject:model];
        }
        
    }
    
    return _menuArray;
}


@end
