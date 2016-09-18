//
//  Quartz2D_HandleImageView.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/9/1.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "Quartz2D_HandleImageView.h"

@interface Quartz2D_HandleImageView () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIImageView * imageView;

@end

@implementation Quartz2D_HandleImageView

#pragma mark - PraviteFunctions

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //拦截事件，避免添加图片后还能继续绘图
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView = imageView;
        imageView.userInteractionEnabled = YES;
        
        [self addSubview:_imageView];
        
        [self setupGestureRecongnized];
    }
    
    return  _imageView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = _image;
}




- (void)setupGestureRecongnized {
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [_imageView addGestureRecognizer:pan];
    
    
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    [_imageView addGestureRecognizer:pinch];
    
    
    UIRotationGestureRecognizer * rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    [_imageView addGestureRecognizer:rotation];
    
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.delegate = self;
    [_imageView addGestureRecognizer:longPress];
}

- (void)pan: (UIPanGestureRecognizer *)pan {
    //获取改变量
    CGPoint location = [pan translationInView:_imageView];
    
    CGAffineTransform transform = CGAffineTransformTranslate(_imageView.transform, location.x, location.y);
    
    _imageView.transform = transform;

    //置零
    [pan setTranslation:CGPointZero inView:self];
}

- (void)pinch: (UIPinchGestureRecognizer *)pinch {
    
    CGAffineTransform transform = CGAffineTransformScale(_imageView.transform, pinch.scale, pinch.scale);
    
    _imageView.transform = transform;
    
    [pinch setScale:1];
    
}


- (void)rotation: (UIRotationGestureRecognizer *)rotation {
    
    CGAffineTransform transform = CGAffineTransformRotate(_imageView.transform, rotation.rotation);
    
    _imageView.transform = transform;
    
    [rotation setRotation:0];
    
}

- (void)longPress: (UILongPressGestureRecognizer *)longPress {
    
    
    if (longPress.state != UIGestureRecognizerStateBegan) return;
    
    //创建提示框
    UIAlertAction * certain = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取长按时长
        CFTimeInterval time = longPress.minimumPressDuration;
        [self drawImageToBoard:time];
        
        //长按生成UIImage传递给画板
        [self drawImageToBoard:time];
    }];
    
    UIAlertAction * delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        /** 删除 */
        [self removeFromSuperview];
    }];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击确定绘制到画板" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:certain];
    [alert addAction:delete];
    [alert addAction:cancle];
    
    [((UINavigationController *)self.window.rootViewController).viewControllers.lastObject presentViewController:alert animated:YES completion:nil];
}

- (void)drawImageToBoard: (CFTimeInterval)duration {
    //1.生成图片
    
    //1.1开启位图环境
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //1.2渲染图层到环境
    [self.layer renderInContext:context];
    
    //1.3获取图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //1.4关闭环境
    UIGraphicsEndImageContext();
    
    
    
    
    //制作高亮动画

    
    [UIView animateWithDuration:duration / 2  animations:^{
        
        self.imageView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:duration / 2 animations:^{
            
            self.imageView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            //2.传递图片到父控件
            if (_handleImage) {
                self.handleImage(newImage);
            }
            
            //从父控件中移除
            [self removeFromSuperview];
            
        }];
        
    }];
    
}

#pragma mark - UIGestureRecongnizedDelegate

//允许使用多个手势

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
