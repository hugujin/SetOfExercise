//
//  UIImage+Quartz2D_Portrait.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/26.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "UIImage+Quartz2D_Portrait.h"

@implementation UIImage (Quartz2D_Portrait)

+ (instancetype)imageWithPortraitImage: (NSString *)imageName borderWith: (CGFloat)with borderColor: (UIColor *)color {
    
    //获取图片
    UIImage * image = [UIImage imageNamed:imageName];
    CGSize imageSize = image.size;
    CGRect imageRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    CGFloat imageWH = image.size.height;
    CGFloat border = with;
    
    //开启位图环境
    UIGraphicsBeginImageContext(imageSize);
    
    //绘制大圆
    UIBezierPath * ringPath = [UIBezierPath bezierPathWithOvalInRect: imageRect];
    //给蓝色
    [color set];
    //填充
    [ringPath fill];
    
    //截取圆形图片
    //生成圆形路径
    UIBezierPath * ciclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH - border * 2, imageWH - border * 2)];
    //改变路径为裁剪路径
    [ciclePath addClip];
    
    //绘制图片
    [image drawInRect:imageRect];
    
    /** 用CG框架获取的图片默认是倒置的 */
    
    //绘制图片到该环境
    //    CGContextDrawImage(context, CGRectMake(0, 0, 160, 160), [UIImage imageNamed:@"阿狸头像"].CGImage);
    //生成新图片(倒置的图片)
    //    CGImageRef newImage = CGBitmapContextCreateImage(context);
    //    //显示图片
    //    self.portraitView.image = [UIImage imageWithCGImage:newImage];
    
    /** 用CG框架获取的图片默认是倒置的 */
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭环境
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
