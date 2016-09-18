//
//  Adress_ContactController.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/12.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

//联系人路径
#define contactPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"contact.data"]


#import "Adress_ContactController.h"
#import "Adress_AddContactController.h"
#import "Adress_ContactModel.h"
#import "Adress_EditContactController.h"

@interface Adress_ContactController ()

/** 表示图数据 */
@property (nonatomic, strong) NSMutableArray<Adress_ContactModel *> * tableArray;

@end


@implementation Adress_ContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //去掉多余分割线
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //解档
    self.tableArray = [NSKeyedUnarchiver unarchiveObjectWithFile:contactPath];
    
}

//tableView和view在该类型控制器中指向同一空间。
//这个方法调用完成后才请求表示图的区
//- (void)loadView {
//    self.tableView = [[UITableView alloc]init];
//    
//}

//这个方法调用完成之后才会开始请求表示图单元格数据，所以数据源数组的赋值可以在这个函数之前的所有函数里面实现
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}


#pragma mark - ButtonAction
- (IBAction)LogoutAction:(id)sender {
    
    //弹框
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"确定要注销吗" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
        // 添加事件
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }];
        [alert addAction:sure];
        [alert addAction:cancel];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Adress_ContactModel * model = self.tableArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.phone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //send contactModle to next page
    //push editContact page
    [self performSegueWithIdentifier:@"editContactSegue" sender:indexPath];
    
    
}


#pragma mark - overrideFunctions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //添加
    if ([segue.identifier isEqualToString:@"addContactSegue"]) {
        Adress_AddContactController * desVc = segue.destinationViewController;
        
        //定义回调函数
        desVc.addContactBlock = ^(Adress_ContactModel * model) {
            [self.tableArray addObject:model];
            
            //归档
            [self keydArchiverContact];
            
            //刷新表示图
            [self.tableView reloadData];
        };
    }
    
    //编辑
    if ([segue.identifier isEqualToString:@"editContactSegue"]) {
        Adress_EditContactController * editVc = segue.destinationViewController;
        NSIndexPath * indexPath = (NSIndexPath *)sender;
        
        //设置数据和block
        editVc.model = self.tableArray[indexPath.row];
        
        editVc.editContactBlock = ^() {
            //刷新表视图
            [self.tableView reloadData];
            
            //归档
            [self keydArchiverContact];
        };
        
    }
}



#pragma mark - PraviteFunctions

- (NSMutableArray *)tableArray {
    if (!_tableArray) {
        _tableArray = [[NSMutableArray alloc]init];
    }
    return _tableArray;
}

/** 通讯录归档 */
- (void)keydArchiverContact {
    
    //归档
    if (![NSKeyedArchiver archiveRootObject:self.tableArray toFile:contactPath]) {
        NSLog(@"归档失败！");
    }
    
}

@end
