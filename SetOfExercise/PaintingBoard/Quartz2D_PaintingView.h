//
//  Quartz2D_PaintingView.h
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/30.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Quartz2D_PaintingView : UIView

@property (nonatomic, strong) UIColor * color;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) UIImage * image;

- (void)clearScreen;

- (void)cancle;

- (void)eraser;

- (void)savePainting;

@end
