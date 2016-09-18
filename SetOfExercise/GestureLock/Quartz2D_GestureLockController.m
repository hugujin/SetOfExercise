//
//  Quartz2D_GestureLockController.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/24.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "Quartz2D_GestureLockController.h"
#import "UIImage+Quartz2D_Portrait.h"

@interface Quartz2D_GestureLockController ()
@property (weak, nonatomic) IBOutlet UIImageView *portraitView;

@end

@implementation Quartz2D_GestureLockController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //利用分类创头像
    self.portraitView.image = [UIImage imageWithPortraitImage:@"阿狸头像" borderWith:2 borderColor:[UIColor greenColor]];
    
    //绘制背景
    //0.获取图片
    UIImage * backImage = [UIImage imageNamed:@"gesture_Home_refresh_bg"];
    
    //1.开启环境
    UIGraphicsBeginImageContext(backImage.size);
    
    //2.绘制图片
    [backImage drawInRect:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    
    //2.1 设置图片到self.view的主图层上
    self.view.layer.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    
    //3.关闭环境
    UIGraphicsEndImageContext();
}




@end
