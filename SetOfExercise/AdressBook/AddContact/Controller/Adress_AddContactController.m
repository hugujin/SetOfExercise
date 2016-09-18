//
//  Adress_AddContactController.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/13.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "Adress_AddContactController.h"
#import "Adress_ContactModel.h"

@interface Adress_AddContactController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation Adress_AddContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    //显示键盘
    [self.nameField becomeFirstResponder];
}

#pragma mark - buttonAction

- (IBAction)textFieldChange {
    
    self.addBtn.enabled = self.nameField.text.length && self.phoneField.text.length;
    
}

- (IBAction)addContactAction {
    
    //包装数据
    Adress_ContactModel * model = [Adress_ContactModel contactWithName:self.nameField.text phone:self.phoneField.text];
    
    //调用block回传
    if (_addContactBlock) {
        _addContactBlock(model);
    }
    
    //返回上一页面
    [self.navigationController popViewControllerAnimated:YES];
}


@end
