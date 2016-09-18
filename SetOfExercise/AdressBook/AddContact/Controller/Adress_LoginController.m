//
//  Adress_LoginController.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/12.
//  Copyright © 2016年 胡古斤. All rights reserved.
//
#define HGJUserDefaults [NSUserDefaults standardUserDefaults]

#import "Adress_LoginController.h"
#import "Adress_ContactController.h"
#import "MBProgressHUD.h"

@interface Adress_LoginController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UISwitch *remberPwd;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin;
@end

@implementation Adress_LoginController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //读取偏好设置信息设置ui
    NSString * account = [HGJUserDefaults objectForKey:@"account"];
    NSString * pwd = [HGJUserDefaults objectForKey:@"pwd"];
    BOOL remberPwd = [HGJUserDefaults boolForKey:@"remberPwd"];
    BOOL autoLogin = [HGJUserDefaults boolForKey:@"autoLogin"];
    
    self.remberPwd.on = remberPwd;
    self.autoLogin.on = autoLogin;
    
    //记住密码
    if (self.remberPwd.on) {
        self.accountField.text = account;
        self.pwdField.text = pwd;
    }
    
    //自动登录
    if (self.autoLogin.on) {
        [self LoginAction];
    }
    
    //加载完成判断是否有帐号密码来允许点击登陆
    [self textFieldChange];

}

- (instancetype)init {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"AdressBookStorybord" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
    return self;
}


#pragma mark - Action

- (IBAction)textFieldChange {
    
    self.loginBtn.enabled = self.accountField.text.length && self.pwdField.text.length;

}

- (IBAction)remberPwd:(UISwitch *)sender {
    
    //如果不记住密码，要取消自动登录
    if (!sender.on) {
        [self.autoLogin setOn:false animated:YES];
    }
}

- (IBAction)autoLogin:(UISwitch *)sender {
    //自动登录时必须记住密码
    if (sender.on) {
        [self.remberPwd setOn:YES animated:YES];
    }
}

- (IBAction)LoginAction {
    
    
    //请求数据过程添加蒙板
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];

    //判断帐号密码正确性
    if ([self.accountField.text isEqualToString:@"HGJ"] && [self.pwdField.text isEqualToString:@"123"] ) {
        
        [hud showAnimated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //隐藏蒙板
            [hud hideAnimated:YES];
            
            //偏好设置存储
            [HGJUserDefaults setObject:self.accountField.text forKey:@"account"];
            [HGJUserDefaults setObject:self.pwdField.text forKey:@"pwd"];
            [HGJUserDefaults setBool:self.remberPwd.on forKey:@"remberPwd"];
            [HGJUserDefaults setBool:self.autoLogin.on forKey:@"autoLogin"];
            
            //正确直接跳转
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        });
        
        
    }else {
        //错误给提示
        hud.label.text = @"帐号或密码错误";
        hud.mode = MBProgressHUDModeText;
        hud.minShowTime = 0.5;
        [hud showAnimated:YES];
        [hud hideAnimated:YES];
    }
    
    
    
}



#pragma mark - overrideFunctions

/** 拿到分镜创建的箭头 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //修改目标控制器标题
    Adress_ContactController * desVc = segue.destinationViewController;
    desVc.title = [NSString stringWithFormat:@"%@的通讯录", self.accountField.text];
    
}

@end
