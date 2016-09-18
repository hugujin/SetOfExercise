//
//  UIImage+Quartz2D_Portrait.h
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/26.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Quartz2D_Portrait)

+ (instancetype)imageWithPortraitImage: (NSString *)imageName borderWith: (CGFloat)with borderColor: (UIColor *)color;

@end
