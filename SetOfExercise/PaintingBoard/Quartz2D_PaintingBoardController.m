//
//  Quartz2D_PaintingBoardController.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/30.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "Quartz2D_PaintingBoardController.h"
#import "Quartz2D_PaintingView.h"
#import "Quartz2D_HandleImageView.h"
#import "MBProgressHUD.h"

@interface Quartz2D_PaintingBoardController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet Quartz2D_PaintingView *paintingView;


@end



@implementation Quartz2D_PaintingBoardController

- (void)viewDidLoad {
    
}


#pragma mark - buttonAction

//更改线条颜色
- (IBAction)changeColorAction:(UIButton *)sender {
    
    [self.paintingView setColor:sender.backgroundColor];
}

//更改线条宽度
- (IBAction)changeLineWidth:(UISlider *)sender {
    
    [self.paintingView setWidth:sender.value];
}

//清屏
- (IBAction)clearScreen:(id)sender {
    [self.paintingView clearScreen];
}

//撤销
- (IBAction)cancle:(id)sender {
    [self.paintingView cancle];
}

//橡皮擦
- (IBAction)eraser:(id)sender {
    [self.paintingView eraser];
}

//打开相册
- (IBAction)photo:(id)sender {
    UIImagePickerController * pickerVc = [[UIImagePickerController alloc]init];
    
    pickerVc.delegate = self;
    
    //设置来源为直接进入图片库
    pickerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    
    
    [self presentViewController:pickerVc animated:YES completion:nil];
    
}


//保存图
- (IBAction)savePainting:(id)sender {
    
    [self.paintingView savePainting];
    
}

#pragma mark - UIImagePikcerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //获取图片
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    //创建一个Quartz2D_HandleImageview
    Quartz2D_HandleImageView * handleView = [[Quartz2D_HandleImageView alloc]initWithFrame:self.paintingView.bounds];
    handleView.image = image;
    handleView.handleImage = ^(UIImage * image) {
        _paintingView.image = image;
    };
    [self.paintingView addSubview:handleView];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //创建提示框
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    
    hud.label.text = @"添加图片成功,长按绘制到画板";
    
    [hud hideAnimated:YES afterDelay:1.5];
    
}




@end
