//
//  HGJChattingController.m
//  HGJChatting
//
//  Created by 胡古斤 on 16/7/9.
//  Copyright © 2016年 胡古斤. All rights reserved.
//


#import "HGJChattingController.h"
#import "HGJChattingCell.h"
#import "HGJChattingModel.h"
#import "MBProgressHUD.h"

#define path [[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil]

@interface HGJChattingController () <UITextFieldDelegate>

@property (strong, nonatomic) NSArray * messageArray;

/** 输入栏 */
@property (weak, nonatomic) UITextField * inputField;

/** 删除对话的回调 */
@property (strong, nonatomic) void(^delAction)(NSIndexPath * index);

@end

@implementation HGJChattingController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    
    /* 输入功能  2016.9.13 */
    
    //避免块中循环引用
    __weak UITableView * tView = self.tableView;
    
    //1.设置回调函数
    self.delAction = ^(NSIndexPath * index) {
        //创建提示框
        UIAlertAction * delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            //不允许删除自带数据
            if (index.row <= 8) {
                
                MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"不允许删除系统数据";
                [hud hideAnimated:YES afterDelay:1.5];
                
                return;
            }
            
            
            //删除对应行会话，并保存
            NSArray * messagesArr = [NSArray arrayWithContentsOfFile:path];
            NSMutableArray * saveArr = [NSMutableArray arrayWithArray:messagesArr];
            [saveArr removeObjectAtIndex:index.row];
            [saveArr writeToFile:path atomically:YES];
            
            //刷新数据
            _messageArray = nil;
            [tView reloadData];
            
        }];
        
        UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击删除移除该会话" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:delete];
        [alert addAction:cancle];
        
        [((UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController).viewControllers.lastObject presentViewController:alert animated:YES completion:nil];
    };
    
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HGJChattingCell * cell = [HGJChattingCell cellWithTableView:tableView];
    cell.model = self.messageArray[indexPath.row];
    
    /* 新增  2016.9.13 */
    cell.index = indexPath;
    cell.delAction = self.delAction;
    /* 新增  2016.9.13 */
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HGJChattingModel * model = self.messageArray[indexPath.row];
    return model.height;
}




#pragma mark - ButtonAction
- (void)send {
    
    [self.inputField resignFirstResponder];
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {

    //创建model
    HGJChattingModel * model = [HGJChattingModel modelWithText:textField.text];
    
    //存入本地
    NSArray * messagesArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray * saveArr = [NSMutableArray arrayWithArray:messagesArr];
    NSDictionary * dic = [HGJChattingModel dicFromModel:model];
    [saveArr addObject:dic];
    [saveArr writeToFile:path atomically:YES];
    
    //重载数据
    self.messageArray = nil;
    [self.tableView reloadData];
    
    //清空输入栏
    self.inputField.text = @"";
    
}



#pragma mark - PrivateFunctions

/**
 *  懒加载表视图数据 */
- (NSArray *)messageArray
{
    if (!_messageArray) {
        NSArray * messagesArr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray * temp = [NSMutableArray array];
        
        NSString * time;
        for (NSDictionary * dic in messagesArr) {
            HGJChattingModel * model = [HGJChattingModel modelWithDic:dic];
            model.timeHidden = [time isEqualToString:model.time];
            time = model.time;
            [temp addObject:model];
        }
        
        _messageArray = temp;
    }
    
    return _messageArray;
}

- (void)setUpTableView
{
    self.tableView.backgroundColor = [UIColor colorWithRed:225 / 255.0 green:213 / 255.0 blue:146 / 255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = false;
}




@end
