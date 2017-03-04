//
//  Quartz2D_PaintingView.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/30.
//  Copyright © 2016年 胡古斤. All rights reserved.
//




#import "Quartz2D_PaintingView.h"
#import "MBProgressHUD.h"


//用来存储路径属性（如果把路径颜色属性也存进去会出现问题，可能CGColorRef结构体嵌套进去只会被编码一个指针，颜色信息保存不完整。CGColorRef结构体内部没有公布，不能单独打包。）
struct Path {
    CGFloat pathWidth;
};

@interface Quartz2D_PaintingView ()

@property (assign, nonatomic) CGMutablePathRef path;

@property (nonatomic, assign) CGContextRef context;

@property (nonatomic, strong) NSMutableArray * pathsArr;

@property (strong, nonatomic) NSMutableArray * pathColor;

@property (nonatomic, strong) NSMutableArray <NSData *>* pathWidth;

@end


@implementation Quartz2D_PaintingView


- (void)awakeFromNib {
    self.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    self.width = 1;
}


- (void)drawRect:(CGRect)rect {

    //获取layer环境
    _context = UIGraphicsGetCurrentContext();
    
    //添加路径
    for (int i = 0; i < _pathsArr.count; ++i) {
        
        if ([_pathsArr[i] isKindOfClass:[UIImage class]]) {
            
            //绘制图片
            UIImage * image = _pathsArr[i];
            [image drawInRect:rect];
            
        }else {
            //绘制线条
            //设置颜色
            CGContextAddPath(_context, (__bridge CGMutablePathRef __nullable)_pathsArr[i]);
            const CGFloat * __nullable components = CGColorGetComponents(((UIColor *)self.pathColor[i]).CGColor);
            CGContextSetStrokeColor(_context, components);
            
            //设置线宽(解码结构体)
            struct Path pathAttritute;
            [self.pathWidth[i] getBytes:&pathAttritute length:sizeof(struct Path)];
            CGContextSetLineWidth(_context, pathAttritute.pathWidth );
            
            //绘制路径
            CGContextStrokePath(_context);
        }
        
    }
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    //全手动管理路径属性
    //1.添加颜色信息到数组
    [self.pathColor addObject:self.color];
    
    //2.添加线条宽度到结构体(编码结构体)
    struct Path pathArrtibute;
    pathArrtibute.pathWidth = self.width;
    NSData * data = [NSData dataWithBytes:&pathArrtibute length:sizeof(struct Path)];
    [self.pathWidth addObject:data];
    
    
    
    //获取起始点
    CGPoint start = [touches.anyObject locationInView:self];

    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    _path = path;
    
    //加入路径数组(要用两个指针去引用这个路径，一个用来保存信息，一个用来供其他地方使用)
    [self.pathsArr addObject:(__bridge id _Nonnull)(path)];
    
    //移动路径到起始点
    CGPathMoveToPoint(_path, nil, start.x, start.y);
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获取移动点
    CGPoint move = [touches.anyObject locationInView:self];
    
    //添加线到路径
    CGPathAddLineToPoint(_path, nil, move.x, move.y);
    
    //刷新
    [self setNeedsDisplay];
}

#pragma mark - publicFunctions

- (void)clearScreen {
    [self.pathsArr removeAllObjects];
    [self.pathWidth removeAllObjects];
    [self.pathColor removeAllObjects];
    [self setNeedsDisplay];
}

- (void)cancle {
    [self.pathsArr removeLastObject];
    [self.pathWidth removeLastObject];
    [self.pathColor removeLastObject];
    [self setNeedsDisplay];
}

- (void)eraser {
    self.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
}


- (void)savePainting {
    
    //截图生成图片
    //1.开启位图环境
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.渲染图层
    [self.layer renderInContext:context];
    
    //3.生成图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //4.关闭环境
    UIGraphicsEndImageContext();
    
    
    //保存图片到相册
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
}

#pragma mark - saveImageSEL
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"保存图片成功,赶紧分享到朋友圈";
    [hud hideAnimated:YES afterDelay:2];
}

#pragma mark - praviteFunctions

- (void)setImage:(UIImage *)image {
    
    [self.pathsArr addObject:image];
    
    struct Path pathArrtibute;
    NSData * data = [NSData dataWithBytes:&pathArrtibute length:sizeof(struct Path)];
    [self.pathWidth addObject:data];
    [self.pathColor addObject:self.color];
    
    [self setNeedsDisplay];
}

- (NSMutableArray *)pathsArr {
    
    if (!_pathsArr) {
        _pathsArr = [[NSMutableArray alloc]init];
    }
    return  _pathsArr;
}

- (NSMutableArray *)pathColor {
    if (!_pathColor) {
        _pathColor = [[NSMutableArray alloc]init];
    }
    return  _pathColor;
}

- (NSMutableArray<NSData *> *)pathWidth {
    if (!_pathWidth) {
        _pathWidth = [[NSMutableArray alloc]init];
    }
    return  _pathWidth;
}

@end
