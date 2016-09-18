//
//  Quartz2D_LockView.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/24.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "Quartz2D_LockView.h"
#import "MBProgressHUD.h"

//设置手势行列数
#define row 3
#define col 3

@interface Quartz2D_LockView ()

@property (nonatomic, strong) NSMutableArray<UIButton *> * selectedBtns;

/** 手势当前点 */
@property (nonatomic, assign) CGPoint panLocation;


@end


@implementation Quartz2D_LockView



#pragma mark - inital
- (void)awakeFromNib {
    
    //添加手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(unlock:)];
    [self addGestureRecognizer:pan];
    
    //创建按钮
    [self setUpButton];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(unlock:)];
        [self addGestureRecognizer:pan];
         
        //创建按钮
        [self setUpButton];
    }
    return self;
}


#pragma mark - override

- (void)drawRect:(CGRect)rect {
    
    if (!self.selectedBtns.count) return;
    
    //根据选中的按钮数组绘制路径
    
    //1.创建路径
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinRound;
    [[UIColor greenColor] set];
    
    //2.创建按钮之间的线条
    for (int i = 0; i < _selectedBtns.count; ++i) {
        if (!i) {
            [path moveToPoint:_selectedBtns.firstObject.center];
            continue;
        }
        [path addLineToPoint:_selectedBtns[i].center];
    }
    
    //如果还没有选中任何图片的话，绘制一个当前按钮到手势的线条
    [path addLineToPoint:_panLocation];
    
    [path stroke];
}

#pragma mark - Action
- (void)unlock: (UIPanGestureRecognizer *)pan {
    
    self.panLocation = [pan locationInView:self];
    
    //添加选中按钮至数组
    for (UIButton * btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, _panLocation) && btn.selected == false) {
            [self.selectedBtns addObject:btn];
            btn.selected = YES;
        }
    }
    
    //手势结束
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        //设置所有按钮为未选中
        for (int i = 0; i < self.subviews.count; ++i) {
            UIButton * btn = [self subviews][i];
            btn.selected = false;
            
        }
        
        //获取密码
        NSString * password = [[NSString alloc]init];
        for (int i = 0; i < _selectedBtns.count; ++i) {
            ;
            password = [NSString stringWithFormat:@"%@%ld", password, _selectedBtns[i].tag];
        }
        
        //验证密码
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
        hud.mode = MBProgressHUDModeText;
        if ([password isEqualToString:@"1235789"]) {
            hud.label.text = @"密码正确";
        }else {
            hud.label.text = @"密码错误，正确手势为Z";
        }
        [hud hideAnimated:YES afterDelay:1.5];
        
        //删除所有选中按钮
        [_selectedBtns removeAllObjects];
        
    }
    
    //重新绘制
    [self setNeedsDisplay];
}


#pragma mark - 布局按钮

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //设置界面参数
    CGFloat btnWH = 74;
    CGFloat border = (self.bounds.size.width - col * btnWH) / (col + 1);
    CGFloat x, y;
    
    for (int i = 0; i < [self subviews].count; ++i) {
        
        UIButton * btn = [self subviews][i];
        x = border + i % col * (btnWH + border);
        y = i / col * (btnWH + border);
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
    }
    
}


#pragma mark - PraviteFunctions

- (NSMutableArray<UIButton *> *)selectedBtns {
    
    if (!_selectedBtns) {
        _selectedBtns = [NSMutableArray array];
    }
    
    return _selectedBtns;
    
}

- (void)setUpButton {
    //创建按钮
    //1.获取图片
    UIImage * normalImage = [UIImage imageNamed:@"gesture_node_normal"];
    UIImage * selectedImage = [UIImage imageNamed:@"gesture_node_highlighted"];
    
    //2.创建
    for (int i = 0; i < row * col; ++i) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:normalImage forState:UIControlStateNormal];
        [btn setImage:selectedImage forState:UIControlStateSelected];
        btn.userInteractionEnabled = false;
        
        //根据tag设置数字密码
        btn.tag = i + 1;
        
        [self addSubview:btn];
    }

}

@end
