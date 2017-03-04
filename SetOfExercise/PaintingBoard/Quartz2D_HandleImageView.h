//
//  Quartz2D_HandleImageView.h
//  SetOfExercise
//
//  Created by 胡古斤 on 16/9/1.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Quartz2D_HandleImageView : UIView

@property (nonatomic, strong) UIImage * image;

@property (nonatomic, strong) void (^handleImage) (UIImage * image);

@end
