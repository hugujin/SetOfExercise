//
//  HGJChattingCell.m
//  HGJChatting
//
//  Created by 胡古斤 on 16/7/9.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "HGJChattingCell.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface HGJChattingCell ()

    @property (weak, nonatomic) IBOutlet UILabel *timeLabel;
    
    @property (weak, nonatomic) IBOutlet UIImageView *otherProtrait;
    @property (weak, nonatomic) IBOutlet UIButton *leftStatus;
    
    @property (weak, nonatomic) IBOutlet UIImageView *mineProtrait;
    @property (weak, nonatomic) IBOutlet UIButton *rightStatus;

@end

@implementation HGJChattingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
    self.leftStatus.titleLabel.numberOfLines = 0;
    self.rightStatus.titleLabel.numberOfLines = 0;
    
    /** 新增  2016.9.13 */
    
    UILongPressGestureRecognizer * longPress1 = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongPressAction:)];
    UILongPressGestureRecognizer * longPress2 = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongPressAction:)];
    [self.leftStatus addGestureRecognizer:longPress1];
    [self.rightStatus addGestureRecognizer:longPress2];
    
    /** 新增  2016.9.13 */
}


#pragma mark - ButtonAction

/** 新增  2016.9.13 */


- (void)LongPressAction:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (_delAction) {
            _delAction(self.index);
        }
    }
    
}



/** 新增  2016.9.13 */





/**
 *  创建Cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellID = @"HGJChattingCell";
    HGJChattingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"chattingCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil].lastObject;
    }
    return cell;
}



- (void)setModel:(HGJChattingModel *)model
{
    _model = model;

    self.timeLabel.text = model.time;
    self.timeLabel.hidden = model.timeHidden;
    if (self.timeLabel.hidden) {
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
        
    }
    
    if (_model.type == MessageTypeOther) {
        self.mineProtrait.hidden = YES;
        self.rightStatus.hidden = YES;
        [self setHideAndDisplay:self.otherProtrait :self.leftStatus];
    }else if (_model.type == MessageTypeMine) {
        self.otherProtrait.hidden = YES;
        self.leftStatus.hidden = YES;
        [self setHideAndDisplay:self.mineProtrait :self.rightStatus];
    }
    
    return;
}


/**
 *  设置头像，文本框的显示与隐藏
 *  显示
 *  显示
 */
- (void)setHideAndDisplay: (UIImageView *)icon :(UIButton *)button {
    
    [button setTitle:self.model.text forState:UIControlStateNormal];
    icon.hidden = false;
    button.hidden = false;
    
    //设置Button高度和Label高度一致
    [self layoutIfNeeded];
    [button updateConstraints:^(MASConstraintMaker *make) {
        CGFloat height = button.titleLabel.frame.size.height + 30;
        make.height.equalTo(height);
    }];
    
    [button layoutIfNeeded];
    
    // 计算当前cell的高度
    CGFloat buttonMaxY = CGRectGetMaxY(button.frame);
    CGFloat iconMaxY = CGRectGetMaxY(icon.frame);
    self.model.height = MAX(buttonMaxY, iconMaxY) + 10;
}


@end
