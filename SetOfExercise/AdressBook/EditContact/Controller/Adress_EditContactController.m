//
//  Adress_EditContactController.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/13.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "Adress_EditContactController.h"
#import "Adress_ContactModel.h"
#import "Adress_ContactController.h"

@interface Adress_EditContactController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation Adress_EditContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameField.text = self.model.name;
    self.phoneField.text = self.model.phone;
}




- (IBAction)edit:(id)sender {
    
    
    //右边变为取消
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"编辑"]) {
        self.navigationItem.rightBarButtonItem.title = @"取消";
        //允许编辑
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        //弹出键盘
        [self.phoneField becomeFirstResponder];
        
    }else {
        
        //不允许编辑
        self.nameField.enabled = false;
        self.phoneField.enabled = false;
        
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        
        //还原数据
        self.nameField.text = self.model.name;
        self.phoneField.text = self.model.phone;
        
        //判断保存按钮状态
        [self textFieldChange];
    }
    
}


- (IBAction)textFieldChange {
    
    self.saveBtn.enabled = self.nameField.text.length && self.phoneField.text.length && (![self.nameField.text isEqualToString:self.model.name] || ![self.phoneField.text isEqualToString:self.model.phone]);
    
}



- (IBAction)saveAction {
    //更改模型
        //同一指针指向的同一模型
    self.model.name = self.nameField.text;
    self.model.phone = self.phoneField.text;
    
    //调用block
    if (_editContactBlock) {
        _editContactBlock();
    }
    
    //返回上一页面
    [self.navigationController popViewControllerAnimated:YES];
}



@end
